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
})->name('/');

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


Route::resource('/payments',PaymentSpaController::class);
Route::resource('/subjects',SubjectController::class);
Route::resource('/courses',CourseController::class);

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::prefix('master')->middleware([ 'checkRole:master'])->group(function(){
        Route::resource('/studies',App\Http\Controllers\Master\StudyController::class);
        Route::resource('/study_subjects',App\Http\Controllers\Master\StudySubjectController::class)->names('master.studySubjects');
        Route::resource('/subjects',App\Http\Controllers\Master\SubjectController::class)->names('master.subjects');
        Route::resource('/configs',App\Http\Controllers\Master\ConfigController::class);
        Route::resource('/transcriptTemplate',App\Http\Controllers\Master\TranscriptTemplateController::class);
        Route::resource('/roles',App\Http\Controllers\Master\RoleController::class);
        Route::resource('/users',App\Http\Controllers\Master\UserController::class);
    });

    Route::prefix('admin')->middleware([ 'checkRole:master|admin'])->group(function(){
        Route::resource('/',App\Http\Controllers\Admin\DashboardController::class)->names('admin');
        Route::resource('staffs',App\Http\Controllers\Admin\StaffController::class)->names('admin.staffs');
        Route::resource('years',App\Http\Controllers\Admin\YearController::class)->names('admin.years');
        Route::get('year/{year}/grades',[App\Http\Controllers\Admin\YearController::class,'grades'])->name('admin.year.grades');
        Route::resource('/grades',App\Http\Controllers\Admin\GradeController::class)->names('admin.grades');
        Route::get('grade/{grade}/klasses',[App\Http\Controllers\Admin\GradeController::class,'klasses'])->name('admin.grade.klasses');

        Route::get('/grade/{grade}/themes',[App\Http\Controllers\Admin\GradeController::class, 'themes'])->name('admin.grade.themes');


        Route::get('klass/{klass}/courses',[App\Http\Controllers\Admin\KlassController::class,'courses'])->name('admin.klass.courses');
        Route::get('klass/{klass}/students',[App\Http\Controllers\Admin\KlassController::class,'students'])->name('admin.klass.students');
        Route::post('student/sync_courses',[App\Http\Controllers\Admin\StudentController::class,'syncCourses'])->name('admin.klass.syncCourses');
        Route::get('course/{course}/students',[App\Http\Controllers\Admin\CourseController::class,'students'])->name('admin.course.students');
        //Route::put('course/{course}/update_subject_heads',[App\Http\Controllers\Admin\CourseController::class,'updateSubjectHeads'])->name('admin.course.updateSubjectHeads');
        Route::put('course/{course}/update_curse_teachers',[App\Http\Controllers\Admin\CourseController::class,'updateCourseTeachers'])->name('admin.course.updateCourseTeachers');

        // Route::get('grades/year/{year}',[App\Http\Controllers\Admin\GradeController::class,'admin.grades.year']);
        Route::resource('/klasses',App\Http\Controllers\Admin\KlassController::class)->names('admin.klasses');
        // Route::get('klasses/grade/{grade}',[App\Http\Controllers\Admin\KlassController::class,'admin.klasses.grade']);
        Route::resource('/courses',App\Http\Controllers\Admin\CourseController::class)->names('admin.courses');
        Route::resource('/students',App\Http\Controllers\Admin\StudentController::class)->names('admin.students');
        Route::get('/lock_transcripts',[App\Http\Controllers\Admin\TranscriptController::class,'lockTranscripts'])->name('admin.lockTranscripts');
        Route::resource('extracurriculars',App\Http\Controllers\Admin\ExtracurricularController::class)->names('admin.extracurriculars');
        Route::resource('activities',App\Http\Controllers\Admin\ActivityController::class)->names('admin.activities');
    });

    Route::prefix('manage/')->middleware([ 'checkRole:master|admin|director|teacher'])->group(function(){
        Route::get('/',[App\Http\Controllers\Manage\DashboardController::class,'index'])->name('manage');
        Route::resource('/grades',App\Http\Controllers\Manage\GradeController::class);
        Route::resource('/course',App\Http\Controllers\Manage\CourseController::class);
        Route::resource('/student',App\Http\Controllers\Manage\StudentController::class);
        Route::get('/students/get_by_klass_id/{klass}',[App\Http\Controllers\Manage\StudentController::class,'getByKlassId'])->name('manage.students.getByKlassId');
        Route::post('/students/get_by_names',[App\Http\Controllers\Manage\StudentController::class,'getByNames'])->name('manage.students.getByNames');
        Route::resource('/klasses',App\Http\Controllers\Manage\KlassController::class)->names('manage.klasses');
        Route::get('/klass_scores/{klassId}',[App\Http\Controllers\Manage\KlassController::class,'klass_scores']);
        Route::get('klass/{klass}/students',[App\Http\Controllers\Manage\KlassController::class,'students'])->name('manage.klass.students');
        Route::post('/score/update',[App\Http\Controllers\Manage\ScoreController::class,'update'])->name('manage.score.update');
        Route::resource('/score_column',App\Http\Controllers\Manage\ScoreColumnController::class)->names('manage.score_column');
        Route::post('/score_column/reorder',[App\Http\Controllers\Manage\ScoreColumnController::class,'reorder'])->name('manage.score_column.reorder');
        Route::post('/score_column/update_is_total',[App\Http\Controllers\Manage\ScoreColumnController::class,'update_is_total'])->name('manage.score_column.update_is_total');
        Route::get('/klass/{klass}/courses',[App\Http\Controllers\Manage\CourseController::class,'byKlass'])->name('manage.klass.courses');
        Route::get('/klass/{klass}/abilities',[App\Http\Controllers\Manage\AbilityController::class,'byKlass'])->name('manage.klass.abilities');
        Route::post('/klass/{klass}/abilities/update',[App\Http\Controllers\Manage\AbilityController::class,'update'])->name('manage.klass.abilities.update');
        Route::get('/klass/{klass}/habits',[App\Http\Controllers\Manage\HabitController::class,'byKlass'])->name('manage.klass.habits');
        Route::put('/klass/{klass}/habits',[App\Http\Controllers\Manage\HabitController::class,'update'])->name('manage.klass.habits.update');
        Route::get('/transcript/klass_student/{id}',[App\Http\Controllers\Manage\TranscriptController::class,'klassStudent']);
        Route::get('/transcript/klass/{klass}',[App\Http\Controllers\Manage\TranscriptController::class,'klass']);
        Route::resource('/teachers',App\Http\Controllers\Manage\TeacherController::class);
        Route::get('teaching/{teacherId}',[App\Http\Controllers\Manage\TeacherController::class,'teaching'])->name('manage.teaching');   
        Route::get('/course/{course}/scores',[App\Http\Controllers\Manage\CourseController::class,'scores'])->name('manage.course.scores');
        Route::get('/course/{course}/makeups',[App\Http\Controllers\Manage\CourseController::class,'makeups'])->name('manage.course.makeups');
        Route::get('/klass/{klass}/final_scores',[App\Http\Controllers\Manage\KlassController::class,'finalScores'])->name('manage.klass.finalScores');
        Route::get('/klass/{klass}/migrate_transcripts',[App\Http\Controllers\Manage\KlassController::class,'migrateTranscripts'])->name('manage.klass.migrateTranscripts');
        Route::post('/makeup/create_or_cancel',[App\Http\Controllers\Manage\MakeupController::class,'createOrCancel'])->name('manage.makeup.createOrCancel');
        Route::post('/makeup/update',[App\Http\Controllers\Manage\MakeupController::class,'update'])->name('manage.makeup.update');

        Route::resource('additives',App\Http\Controllers\Manage\AdditiveController::class)->names('manage.additives');
        Route::get('klass/{klass}/additive/{category}',[App\Http\Controllers\Manage\AdditiveController::class,'scope'])->name('manage.klass.additive');
        Route::resource('makeups',App\Http\Controllers\Manage\MakeupController::class)->names('manage.makeups');
        Route::resource('tasks',App\Http\Controllers\Manage\TaskController::class)->names('manage.tasks');
        Route::resource('activities',App\Http\Controllers\Manage\ActivityController::class)->names('manage.activities');
        Route::get('activity/{activity}/students',[App\Http\Controllers\Manage\ActivityController::class,'students'])->name('manage.activity.students');
        Route::put('activity/{activity}/students/sync',[App\Http\Controllers\Manage\ActivityController::class,'studentsSync'])->name('manage.activity.students.sync');
        Route::get('activity/{activity}/students/scores',[App\Http\Controllers\Manage\ActivityController::class,'studentsScores'])->name('manage.activity.students.scores');
        Route::put('activity/{activity}/students/scores/update',[App\Http\Controllers\Manage\ActivityController::class,'studentsScoresUpdate'])->name('manage.activity.students.scores.update');
        Route::get('activity/{activity}/students/scores/report',[App\Http\Controllers\Manage\ActivityController::class,'scoreReport'])->name('manage.activity.students.scores.report');
        Route::resource('certificates',App\Http\Controllers\Manage\CertificateController::class)->names('manage.certificates');
        
    });

    Route::prefix('teacher/')->group(function(){
        Route::resource('/',App\Http\Controllers\Teacher\DashboardController::class);
        //Route::resource('/course',App\Http\Controllers\Teachejaon()r\CourseController::class)->names('teacher.course');
    });
});

/*
Route::prefix('promote')->group(function(){
    Route::resource('/',App\Http\Controllers\Admin\PromotionController::class);
    Route::get('getStudents/{klassId}',[App\Http\Controllers\Admin\PromotionController::class,'getStudents']);
    Route::get('getPromotedStudents/{klassId}',[App\Http\Controllers\Admin\PromotionController::class,'getPromotedStudents']);
    Route::post('updateStudents',[App\Http\Controllers\Admin\PromotionController::class,'updateStudents']);
    Route::get('data/{yearId}',[App\Http\Controllers\Admin\PromotionController::class, 'data']);
});


*/