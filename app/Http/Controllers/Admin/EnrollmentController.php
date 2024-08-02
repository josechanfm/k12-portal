<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Student;
use App\Models\Candidate;
use App\Models\Klass;

class EnrollmentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $students=Student::doesntHave('klasses')->get();
        return Inertia::render('Admin/Enrollments',[
            'students'=>Student::doesntHave('klasses')->paginate($request->per_page)
        ]);
   
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $student=Student::find($request->student_id);
        $currentYear=Year::currentYear();
        $nextYear=$currentYear->nextYear();

        if(empty($nextYear)){
            return Inertia::render('Error',[
                'message'=>"需要先創建下一個學年！",
            ]);
        }
        $currentYear->gradesKlasses;
        $nextYear->gradesKlasses;
        //dd($currentYear,$nextYear, $student,);
        if($student->klasses->count()>0){
            return Inertia::render('Error',[
                'message'=>"此學生並非新入學之學生！",
            ]);
        }
        return Inertia::render('Admin/Enrollment',[
            'currentYear'=>$currentYear,
            'nextYear'=>$nextYear,
            'year'=>Year::currentYear(),
            'grades'=>Year::currentYear()->gradesKlasses,
            'student'=>$student,
            'candidate'=>Candidate::where('student_id',$student->id)->first()
        ]);        
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //dd($request->all());
        $klass=Klass::find($request->klass_id);
        $studentNubmer=$klass->students->count()+1;
        $klass->students()->attach($request->student_id,['student_number'=>$studentNubmer,'state'=>'ACT','stream'=>$klass->stream]);
        Candidate::find($request->candidate_id)->update(['enrolled'=>true]);
        return redirect()->route('admin.candidates.index');
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
    public function update(Request $request, $id)
    {
        
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
