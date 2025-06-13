<?php

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\SupplierController;
use App\Http\Controllers\PaymentSpaController;
use App\Http\Controllers\SubjectController;
use App\Http\Controllers\CourseController;
// use App\Http\Controllers\Admin\KlassController;
// use App\Http\Controllers\Admin\YearController;
// use App\Http\Controllers\Admin\GradeController;
// use App\Http\Controllers\Admin\YearPlanController;
use App\Http\Controllers\Admin\PromotionController;
use Illuminate\Http\Request;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
})->name('home');


Route::get('/manual', function (Request $request) {
    $manual=App\Models\Manual::where('route',$request->route)->first();
    if(empty($manual)){
        $manual=App\Models\Manual::where('route','default')->first();
    }
    return Inertia::render('Manual', [
        'manual' => $manual,
    ]);
})->name('manual');



Route::group([
    'prefix'=>'/master',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        'role:master|admin'
    ]
],function () {
        Route::get('/', function () {
        dd('master');
    })->name('master');
});

Route::get('forms', [\App\Http\Controllers\FormController::class, 'index'])->name('forms');
Route::post('form', [\App\Http\Controllers\FormController::class, 'store'])->name('form.store');
Route::get('form', [\App\Http\Controllers\FormController::class, 'show'])->name('form.show');



//admin
Route::group([
    'prefix'=>'/admin',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        'role:master|admin'
    ]
],function () {
    Route::get('/',[App\Http\Controllers\Admin\DashboardController::class,'index'])->name('admin.dashboard');

    Route::resource('forms', App\Http\Controllers\Admin\FormController::class)->names('admin.forms');
    Route::resource('form/{form}/fields', App\Http\Controllers\Admin\FormFieldController::class)->names('admin.form.fields');
    Route::resource('form/{form}/entries', App\Http\Controllers\Admin\EntryController::class)->names('admin.form.entries');
    Route::get('entry/{form}/export', [App\Http\Controllers\Admin\EntryController::class, 'export'])->name('admin.entry.export');
    Route::get('form/{form}/entry/{entry}/success', [App\Http\Controllers\Admin\EntryController::class, 'success'])->name('admin.form.entry.success');
    Route::post('form/delete_media/{form}', [App\Http\Controllers\Admin\FormController::class, 'deleteMedia'])->name('admin.form.deleteMedia');


});



Route::group([
    'prefix'=>'/guardian',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        ]
],function () {
    Route::get('/', [App\Http\Controllers\Guardian\DashboardController::class,'index'])->name('guardian.dashboard');
    Route::resource('profile', App\Http\Controllers\Guardian\ProfileController::class)->names('guardian.profile')->parameters(['profile' => 'guardian']);
});

Route::group([
    'prefix'=>'/student',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        ]
],function () {
    Route::get('/', [App\Http\Controllers\Student\DashboardController::class,'index'])->name('student.dashboard');

});

require __DIR__ . '/auth.php';