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
        Route::resource('/subjectTemplate',App\Http\Controllers\Master\SubjectTemplateController::class);
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
    Route::resource('/study/subjects',App\Http\Controllers\Master\SubjectController::class);
    Route::resource('/subjectTemplate',App\Http\Controllers\Master\SubjectTemplateController::class);
    Route::resource('/configs',App\Http\Controllers\Master\ConfigController::class);
    Route::resource('/transcriptTemplate',App\Http\Controllers\Master\TranscriptTemplateController::class);
    Route::resource('/roles',App\Http\Controllers\Master\RoleController::class);
    Route::resource('/users',App\Http\Controllers\Master\UserController::class);
});

Route::prefix('admin')->group(function(){
    Route::resource('/',App\Http\Controllers\Admin\DashboardController::class);
    Route::resource('/years',App\Http\Controllers\Admin\YearController::class);
    Route::resource('/grades',App\Http\Controllers\Admin\GradeController::class);
    Route::resource('/klasses',App\Http\Controllers\Admin\KlassController::class);
    Route::resource('/gradeSubjects',App\Http\Controllers\Admin\SubjectController::class);
});

Route::prefix('manage/')->group(function(){
    Route::resource('/',App\Http\Controllers\Manage\DashboardController::class);
    Route::resource('/grades',App\Http\Controllers\Manage\GradeController::class);
    Route::get('/courses/{klassId}',[App\Http\Controllers\Manage\GradeController::class, 'courses']);
    Route::get('/students/{klassId}',[App\Http\Controllers\Manage\GradeController::class,'students']);
    Route::get('/klass_scores/{klassId}',[App\Http\Controllers\Manage\KlassController::class,'klass_scores']);
    Route::get('/score',[App\Http\Controllers\Manage\ScoreController::class,'index']);
    Route::post('/score_update',[App\Http\Controllers\Manage\ScoreController::class,'update']);
    Route::resource('/score_column',App\Http\Controllers\Manage\ScoreColumnController::class);
    Route::resource('/course',App\Http\Controllers\Manage\CourseController::class);
    Route::resource('/klass',App\Http\Controllers\Manage\KlassController::class);
    Route::get('/test_data',[App\Http\Controllers\Manage\KlassController::class,'test_data']);
    Route::get('/transcript',[App\Http\Controllers\Manage\TranscriptController::class,'index']);
    Route::get('/transcript/klass_student/{id}',[App\Http\Controllers\Manage\TranscriptController::class,'klassStudent']);
    Route::get('teaching',[App\Http\Controllers\Manage\TeacherController::class,'teaching']);
    Route::resource('/teacher',App\Http\Controllers\Manage\TeacherController::class);
    Route::resource('/student',App\Http\Controllers\Manage\StudentController::class);
    Route::resource('/rpla',App\Http\Controllers\Manage\RplaController::class);
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


