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
});

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {

    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');
    Route::prefix('master')->group(function(){
        Route::resource('/configs',App\Http\Controllers\Master\ConfigController::class);
        Route::resource('/transcriptTemplate',App\Http\Controllers\Master\TranscriptTemplateController::class);
        Route::resource('/users',App\Http\Controllers\Master\UserController::class);
    });
    
});

Route::get('/test',function(){
    return Inertia::render('Welcome');
});

Route::resource('/payments',PaymentSpaController::class);
Route::resource('/subjects',SubjectController::class);
Route::resource('/courses',CourseController::class);

Route::prefix('master')->group(function(){
    Route::resource('/studies',App\Http\Controllers\Master\StudyController::class);
    Route::resource('/study/subjects',App\Http\Controllers\Master\StudySubjectController::class);
    Route::resource('/subjects',App\Http\Controllers\Master\SubjectController::class);
    Route::resource('/configs',App\Http\Controllers\Master\ConfigController::class);
    Route::resource('/transcriptTemplate',App\Http\Controllers\Master\TranscriptTemplateController::class);
    Route::resource('/roles',App\Http\Controllers\Master\RoleController::class);
    Route::resource('/users',App\Http\Controllers\Master\UserController::class);
});

Route::prefix('admin')->group(function(){
    Route::resource('/',App\Http\Controllers\Admin\DashboardController::class)->names('admin');
    Route::resource('years',App\Http\Controllers\Admin\YearController::class)->names('admin.years');
    Route::get('year/{year}/grades',[App\Http\Controllers\Admin\YearController::class,'grades'])->name('admin.year.grades');
    Route::resource('/grades',App\Http\Controllers\Admin\GradeController::class)->names('admin.grades');
    Route::get('grade/{grade}/klasses',[App\Http\Controllers\Admin\GradeController::class,'klasses'])->name('admin.grade.klasses');
    Route::get('klass/{klass}/courses',[App\Http\Controllers\Admin\KlassController::class,'courses'])->name('admin.klass.courses');
    Route::get('klass/{klass}/students',[App\Http\Controllers\Admin\KlassController::class,'students'])->name('admin.klass.students');
    Route::post('student/sync_courses',[App\Http\Controllers\Admin\StudentController::class,'syncCourses'])->name('admin.klass.syncCourses');
    Route::get('course/{course}/students',[App\Http\Controllers\Admin\CourseController::class,'students'])->name('admin.course.students');

    // Route::get('grades/year/{year}',[App\Http\Controllers\Admin\GradeController::class,'admin.grades.year']);
    Route::resource('/klasses',App\Http\Controllers\Admin\KlassController::class)->names('admin.klasses');
    // Route::get('klasses/grade/{grade}',[App\Http\Controllers\Admin\KlassController::class,'admin.klasses.grade']);
    Route::resource('/courses',App\Http\Controllers\Admin\CourseController::class)->names('admin.courses');
    Route::resource('/students',App\Http\Controllers\Admin\StudentController::class)->names('admin.students');
    
});

Route::prefix('manage/')->group(function(){
    Route::resource('/',App\Http\Controllers\Manage\DashboardController::class);
    Route::resource('/grades',App\Http\Controllers\Manage\GradeController::class);
    Route::get('/courses/get_by_klass_id/{klassId}',[App\Http\Controllers\Manage\CourseController::class, 'getByKlassId']);
    Route::get('/students/get_by_klass_id/{klassId}',[App\Http\Controllers\Manage\StudentController::class,'getByKlassId']);
    Route::get('/klass_scores/{klassId}',[App\Http\Controllers\Manage\KlassController::class,'klass_scores']);
    Route::get('/score',[App\Http\Controllers\Manage\ScoreController::class,'index']);
    Route::post('/score_update',[App\Http\Controllers\Manage\ScoreController::class,'update']);
    Route::resource('/score_column',App\Http\Controllers\Manage\ScoreColumnController::class);
    Route::resource('/course',App\Http\Controllers\Manage\CourseController::class);
    Route::resource('/klass',App\Http\Controllers\Manage\KlassController::class);
    Route::get('/test_data',[App\Http\Controllers\Manage\KlassController::class,'test_data']);
    Route::get('/transcript',[App\Http\Controllers\Manage\TranscriptController::class,'index']);
    Route::get('/transcript/klass_student/{id}',[App\Http\Controllers\Manage\TranscriptController::class,'klassStudent']);
    Route::get('teaching/{teacherId}',[App\Http\Controllers\Manage\TeacherController::class,'teaching']);
    Route::resource('/teacher',App\Http\Controllers\Manage\TeacherController::class);
    Route::resource('/student',App\Http\Controllers\Manage\StudentController::class);
    Route::resource('/outcome',App\Http\Controllers\Manage\OutcomeController::class);
    Route::resource('/behaviours',App\Http\Controllers\Manage\BehaviourController::class);
    Route::resource('/habits',App\Http\Controllers\Manage\HabitController::class);
});

Route::prefix('teacher/')->group(function(){
    Route::resource('/',App\Http\Controllers\Teacher\DashboardController::class);
});


Route::prefix('promote')->group(function(){
    Route::resource('/',App\Http\Controllers\Admin\PromotionController::class);
    Route::get('getStudents/{klassId}',[App\Http\Controllers\Admin\PromotionController::class,'getStudents']);
    Route::get('getPromotedStudents/{klassId}',[App\Http\Controllers\Admin\PromotionController::class,'getPromotedStudents']);
    Route::post('updateStudents',[App\Http\Controllers\Admin\PromotionController::class,'updateStudents']);
    Route::get('data/{yearId}',[App\Http\Controllers\Admin\PromotionController::class, 'data']);
});


