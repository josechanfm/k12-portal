<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Storage;
use App\Models\Form;
use Inertia\Inertia;
use App\Exports\EntryExport;
use App\Models\Entry;
use App\Models\EntryRecord;
use App\Models\FormField;
use Illuminate\Support\Facades\Redirect;
use Maatwebsite\Excel\Facades\Excel;
use PDF;


class EntryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Form $form)
    {
        //$form=Form::with('fields')->find($form->id);
        $entries = $form->tableEntries();
        return Inertia::render('Admin/FormEntries', [
            'organization' => session('organization'),
            'form' => $form,
            'entries' => $entries,
            'fields' => $form->fields,
            'entryColumns' => $form->entryColumns()
        ]);
    }
    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Form $form, Entry $entry)
    {
        //
        collect($request->fields)->map(function ($entryField, $key) use ($entry) {
            if (is_array($entryField)) {
                if (isset($entryField['file'])) {
                    $file = $entryField['blob'];
                    $path = Storage::putFile('public/images/forms/photos', $file);
                    $entryField = Storage::url($path);
                }
            }
            $entry->records()->updateOrCreate(
                [
                    'form_field_id' => $key,
                ],
                [
                    'entry_id' => $entry->id,
                    //                'name_en' => $category['name_en'],
                    'form_field_id' => $key,
                    'field_value' => $entryField,
                ]
            );
        });
        return redirect()->back();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Form $form, $id)
    {
        EntryRecord::where('entry_id', $id)->delete();
        Entry::where('id', $id)->delete();

        return Redirect()->back();
        //
    }

    public function export(Form $form)
    {
        // dd($form->excelRecords());
        return Excel::download(new EntryExport($form), $form->title.'.xlsx');
    }

    public function success(Form $form, Entry $entry)
    {
        Session::flash('entry', $entry->id);
        // dd($form, $entry);
        return redirect()->route('form.entry.success', ['form' => $form->id, 'entry' => $entry->id]);
    }
    public function entrySuccess(Form $form, Entry $entry, Request $request)
    {
        $entry_records = EntryRecord::where('entry_id', $entry->id)->with('form_field')->get();
        $form_fields = FormField::where('form_id', $form->id)->get();
        $table_data = [];
        if (strtoupper($request->format) == 'PDF') {
            if (!session('entryPdf') || session('entryPdf') != $entry->id) {
                return redirect()->route('/');
            }
            collect($form_fields)->map(function ($field, $key) use ($entry_records, &$table_data) {
                $entry_record = collect($entry_records)->filter(function ($item) use ($field) {
                    return $item->form_field_id == $field->id;
                })->first();
                if ($field->type == 'radio') {
                    $value = array_filter($field->options, function ($item) use ($entry_record) {
                        return $item->value === $entry_record?->field_value;
                    });
                    // dd($value);
                    $table_data[$field->field_label] = reset($value)->label ?? '';
                    // 
                } else if ($field->type == 'checkbox') {
                    $value = array_filter($field->options, function ($item) use ($entry_record) {
                        return in_array($item->value, json_decode($entry_record->field_value));
                    });
                    $labels = [];
                    foreach ($value as $item) {
                        $labels[] = $item->label;
                    }
                    $result = implode(',', $labels);
                    $table_data[$field->field_label] = $result;
                } else {
                    $table_data[$field->field_label] = $entry_record?->field_value;
                };
            });
            // dd($table_data);
            $pdf = PDF::loadView('Entry/EntrySuccess', [
                'table_data' => $table_data,
            ]);
            // return view('Entry/EntrySuccess', [
            //     'table_data' => $table_data,
            // ]);
            $pdf->render();
            return $pdf->stream('receipt.pdf', array('Attachment' => false));
        } else {
            if (!session('entry') || session('entry') != $entry->id) {
                return redirect()->route('/');
            }
            Session::flash('entryPdf', $entry->id);
            return Inertia::render('Form/Success', [
                'form' => $form,
                'entry' => $entry,
                'entry_records' => $entry_records,
            ]);
        }
    }
    function send()
    {
        $sms_company = env('SMS_COMPANY');
        $sms_username = env('SMS_UID');
        $sms_password = env('SMS_PWD');
        $recipient_xml = "<recipient>63965818</recipient>";
        $content = '測試,test';
        $xml = <<<DATA
        <?xml version='1.0' encoding='UTF-8'?>
        <!DOCTYPE jds SYSTEM '/home/httpd/html/dtd/jds2.dtd'>
        <jds>
        <account acid='{$sms_company}' loginid='{$sms_username}' passwd='{$sms_password}'>
        <msg_send>
        <ref>Reference ID</ref> 
        {$recipient_xml}
        <content>{$content}</content>
        <language>C</language>
        </msg_send>
        </account>
        </jds>
        DATA;

        $url = "https://mlpsmsapi.three.com.mo/v1/externalApi/message";
        $curl = curl_init($url);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        $headers = array(
            "Content-Type: application/xml",
            "Accept: application/xml",
        );
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $xml);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        $resp = curl_exec($curl);
        curl_close($curl);
        $xml = simplexml_load_string($resp);

        return redirect()->back();
    }
}
