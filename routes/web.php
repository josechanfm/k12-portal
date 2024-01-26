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
})->name('abc');


Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');
    Route::get('api/grades_klasses',[App\Http\Controllers\Api\GatherController::class,'gradesKlasses'])->name('api.gradesKlasses');
    Route::get('api/klass_students/{klass}',[App\Http\Controllers\Api\GatherController::class,'klassStudents'])->name('api.klassStudents');
    Route::get('api/student_medical_records/{student}',[App\Http\Controllers\Api\GatherController::class,'studentMedicalRecords'])->name('api.studentMedicalRecords');
    Route::prefix('master')->group(function(){
        Route::resource('/configs',App\Http\Controllers\Master\ConfigController::class);
        Route::resource('/transcriptTemplate',App\Http\Controllers\Master\TranscriptTemplateController::class);
        Route::resource('/users',App\Http\Controllers\Master\UserController::class);
    });
    
});


Route::resource('/payments',PaymentSpaController::class);
Route::resource('/subjects',SubjectController::class);
Route::resource('/courses',CourseController::class);

// Route::middleware([
//     'auth:sanctum',
//     config('jetstream.auth_session'),
//     'verified',
// ])->group(function () {
//     Route::prefix('master')->middleware([ 'checkRole:master'])->group(function(){
Route::group([
    'prefix'=>'/master',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        'role:master|admin'
    ]
],function () {
        Route::resource('/manuals',App\Http\Controllers\Master\ManualController::class)->names('master.manuals');
        Route::resource('/studies',App\Http\Controllers\Master\StudyController::class)->names('master.studies');
        Route::resource('/study_subjects',App\Http\Controllers\Master\StudySubjectController::class)->names('master.studySubjects');
        Route::resource('/subjects',App\Http\Controllers\Master\SubjectController::class)->names('master.subjects');
        Route::resource('/configs',App\Http\Controllers\Master\ConfigController::class)->names('master.configs');
        Route::resource('/transcriptTemplate',App\Http\Controllers\Master\TranscriptTemplateController::class)->names('master.transcriptTemplate');
        Route::resource('/roles',App\Http\Controllers\Master\RoleController::class)->names('master.roles');
        Route::resource('/users',App\Http\Controllers\Master\UserController::class)->names('master.users');
        Route::resource('/grade/{gradeYear}/theme_templates',App\Http\Controllers\Master\ThemeTemplateController::class)->names('master.grade.themeTemplates');
        Route::resource('/grade/{gradeYear}/topic_templates',App\Http\Controllers\Master\TopicTemplateController::class)->names('master.grade.topicTemplates');
        Route::get('/theme_templates',[App\Http\Controllers\Master\ThemeTemplateController::class,'list'])->name('master.themeTemplates');
    });

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
    Route::get('/',[App\Http\Controllers\Admin\DashboardController::class,'index'])->name('admin');
    Route::resource('staffs',App\Http\Controllers\Admin\StaffController::class)->names('admin.staffs');
    Route::resource('years',App\Http\Controllers\Admin\YearController::class)->names('admin.years');
    
    //Route::get('year/{year}/grades',[App\Http\Controllers\Admin\YearController::class,'grades'])->name('admin.year.grades');

    Route::resource('year/{year}/grades',App\Http\Controllers\Admin\GradeController::class)->names('admin.year.grades');
    Route::resource('grade/{grade}/klasses',App\Http\Controllers\Admin\KlassController::class)->names('admin.grade.klasses');
    Route::resource('klass/{klass}/themes',App\Http\Controllers\Admin\ThemeController::class)->names('admin.klass.themes');
    Route::resource('klass/{klass}/topics',App\Http\Controllers\Admin\TopicController::class)->names('admin.klass.topics');
    Route::resource('klass/{klass}/courses',App\Http\Controllers\Admin\CourseController::class)->names('admin.klass.courses');
    Route::resource('{type}/{id}/students',App\Http\Controllers\Admin\StudentController::class)->names('admin.select.students');
    Route::post('student/sync_courses',[App\Http\Controllers\Admin\StudentController::class,'syncCourses'])->name('admin.klass.syncCourses');

    Route::put('course/{course}/update_curse_teachers',[App\Http\Controllers\Admin\CourseController::class,'updateCourseTeachers'])->name('admin.course.updateCourseTeachers');
    
    Route::get('/klasses',[App\Http\Controllers\Admin\KlassController::class,'list'])->name('admin.klasses');
    Route::get('/grades',[App\Http\Controllers\Admin\GradeController::class,'list'])->name('admin.grades');

    Route::resource('/courses',App\Http\Controllers\Admin\CourseController::class)->names('admin.courses');
    Route::resource('/students',App\Http\Controllers\Admin\StudentController::class)->names('admin.students');
    Route::get('/lock_transcripts',[App\Http\Controllers\Admin\TranscriptController::class,'lockTranscripts'])->name('admin.lockTranscripts');
    Route::resource('extracurriculars',App\Http\Controllers\Admin\ExtracurricularController::class)->names('admin.extracurriculars');
    Route::resource('activities',App\Http\Controllers\Admin\ActivityController::class)->names('admin.activities');
    Route::resource('certificates',App\Http\Controllers\Admin\CertificateController::class)->names('admin.certificates');
    Route::get('certificate/print',[App\Http\Controllers\Admin\CertificateController::class,'print'])->name('admin.certificate.print');
    Route::resource('klass/{klass}/behaviours',App\Http\Controllers\Admin\BehaviourController::class)->names('admin.klass.behaviours');
});
//Route::prefix('manage/')->middleware([ 'checkRole:master|admin|director|teacher'])->group(function(){
//manage
Route::group([
    'prefix'=>'/manage',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        'role:master|admin|director|teacher'
    ]
],function () {
        Route::get('/',[App\Http\Controllers\Manage\DashboardController::class,'index'])->name('manage');
        Route::resource('grades',App\Http\Controllers\Manage\GradeController::class)->names('manage.grades');
        Route::resource('course',App\Http\Controllers\Manage\CourseController::class);
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
        Route::get('/klass/{klass}/courses',[App\Http\Controllers\Manage\CourseController::class,'klass'])->name('manage.klass.courses');
        Route::resource('klass/{klass}/behaviours',App\Http\Controllers\Manage\BehaviourController::class)->names('manage.klass.behaviours');
        Route::get('klass/{klass}/behaviour/adjust',[App\Http\Controllers\Manage\BehaviourController::class,'adjust'])->name('manage.klass.behaviour.adjust');
        //Route::get('behaviours',[App\Http\Controllers\Manage\BehaviourController::class,'list'])->name('manage.behaviours');

        Route::get('/year/{year}/transcripts',[App\Http\Controllers\Manage\TranscriptController::class,'yearTranscripts'])->name('manage.year.transcripts');
        Route::get('/grade/{grade}/transcripts',[App\Http\Controllers\Manage\TranscriptController::class,'gradeTranscripts'])->name('manage.grade.transcripts');
        Route::get('/klass/{klass}/transcripts',[App\Http\Controllers\Manage\TranscriptController::class,'klass'])->name('manage.klass.transcripts');
        Route::get('/klass/{klass}/transcripts/migrate',[App\Http\Controllers\Manage\TranscriptController::class,'migrate'])->name('manage.klass.transcripts.migrate');
        Route::get('/klass/student/{klassStudent}/transcript',[App\Http\Controllers\Manage\TranscriptController::class,'klassStudent'])->name('manage.klass.student.transcript');
        Route::get('klass/{klass}/generate_transcripts',[App\Http\Controllers\Manage\TranscriptController::class,'generateTranscripts'])->name('manage.klass.generateTranscripts');
        
        Route::resource('/teachers',App\Http\Controllers\Manage\TeacherController::class);
        Route::get('teaching/{teacherId}',[App\Http\Controllers\Manage\TeacherController::class,'teaching'])->name('manage.teaching');   
        Route::get('/course/{course}/scores',[App\Http\Controllers\Manage\CourseController::class,'scores'])->name('manage.course.scores');
        Route::get('/course/{course}/makeups',[App\Http\Controllers\Manage\CourseController::class,'makeups'])->name('manage.course.makeups');
        Route::get('/klass/{klass}/final_scores',[App\Http\Controllers\Manage\KlassController::class,'finalScores'])->name('manage.klass.finalScores');
        Route::post('/makeup/create_or_cancel',[App\Http\Controllers\Manage\MakeupController::class,'createOrCancel'])->name('manage.makeup.createOrCancel');
        Route::post('/makeup/update',[App\Http\Controllers\Manage\MakeupController::class,'update'])->name('manage.makeup.update');
        
        Route::resource('additives',App\Http\Controllers\Manage\AdditiveController::class)->names('manage.additives');
        Route::get('klass/{klass}/additive/{category}',[App\Http\Controllers\Manage\AdditiveController::class,'scope'])->name('manage.klass.additive');
        Route::get('klass/{klass}/additive_page',[App\Http\Controllers\Manage\AdditiveController::class,'page'])->name('manage.klass.additive.page');
        Route::get('klass/{klass}/additive_direct',[App\Http\Controllers\Manage\AdditiveController::class,'direct'])->name('manage.klass.additive.direct');
        Route::post('klass/{klass}/additive_direct_input',[App\Http\Controllers\Manage\AdditiveController::class,'directInput'])->name('manage.klass.additive.directInput');
        Route::resource('makeups',App\Http\Controllers\Manage\MakeupController::class)->names('manage.makeups');
        Route::resource('tasks',App\Http\Controllers\Manage\TaskController::class)->names('manage.tasks');
        Route::resource('activities',App\Http\Controllers\Manage\ActivityController::class)->names('manage.activities');
        Route::get('activity/{activity}/students',[App\Http\Controllers\Manage\ActivityController::class,'students'])->name('manage.activity.students');
        Route::put('activity/{activity}/students/sync',[App\Http\Controllers\Manage\ActivityController::class,'studentsSync'])->name('manage.activity.students.sync');
        Route::get('activity/{activity}/students/scores',[App\Http\Controllers\Manage\ActivityController::class,'studentsScores'])->name('manage.activity.students.scores');
        Route::put('activity/{activity}/students/scores/update',[App\Http\Controllers\Manage\ActivityController::class,'studentsScoresUpdate'])->name('manage.activity.students.scores.update');
        Route::get('activity/{activity}/students/scores/report',[App\Http\Controllers\Manage\ActivityController::class,'scoreReport'])->name('manage.activity.students.scores.report');
        Route::resource('certificates',App\Http\Controllers\Manage\CertificateController::class)->names('manage.certificates');
        Route::get('certificate/get_by_conditions',[App\Http\Controllers\Manage\CertificateController::class,'getByConditions'])->name('manage.certificate.getByConditions');
        Route::get('promotes',[App\Http\Controllers\Manage\PromotionController::class,'list'])->name('manage.promotes');
        Route::resource('klass/{klass}/promotes/',App\Http\Controllers\Manage\PromotionController::class)->names('manage.klass.promotes');
        // Route::get('klass/{klassId}/promote',[App\Http\Controllers\Manage\PromotionController::class,'klass'])->name('manage.klass.promote');
        // Route::get('getStudents/{klassId}/promote',[App\Http\Controllers\Manage\PromotionController::class,'getStudents'])->name('manage.getStudents.promote');;
        // Route::get('getPromotedStudents/{klassId}/promote',[App\Http\Controllers\Manage\PromotionController::class,'getPromotedStudents'])->name('manage.getPromotedStudents.promote');;
        // Route::post('updateStudents/promote',[App\Http\Controllers\Manage\PromotionController::class,'updateStudents'])->name('manage.updateStudents.promote');;
        // Route::get('data/{yearId}/promote',[App\Http\Controllers\Manage\PromotionController::class, 'data'])->name('manage.data.promote');;
    
        Route::group(['prefix'=>'pre',],function () {
            Route::get('/klass/{klass}/final_scores',[App\Http\Controllers\Manage\Pre\KlassController::class,'finalScores'])->name('manage.pre.klass.finalScores');
            Route::resource('/klasses',App\Http\Controllers\Manage\Pre\KlassController::class)->names('manage.pre.klasses');
            Route::resource('students',App\Http\Controllers\Manage\Pre\StudentController::class)->names('manage.pre.students');
            Route::get('/klass/{klass}/habits',[App\Http\Controllers\Manage\Pre\HabitController::class,'klass'])->name('manage.pre.klass.habits');
            Route::put('/klass/{klass}/habits',[App\Http\Controllers\Manage\Pre\HabitController::class,'update'])->name('manage.pre.klass.habits.update');
            Route::get('/klass/{klass}/habit/export',[App\Http\Controllers\Manage\Pre\HabitController::class,'export'])->name('manage.pre.klass.habit.export');

            Route::get('/klass/{klass}/abilities',[App\Http\Controllers\Manage\Pre\AbilityController::class,'klass'])->name('manage.pre.klass.abilities');
            Route::get('/klass/{klass}/abilities/pdf',[App\Http\Controllers\Manage\Pre\AbilityController::class,'pdf'])->name('manage.pre.klass.abilities.pdf');
            Route::get('/klass/{klass}/abilities/mpdf',[App\Http\Controllers\Manage\Pre\AbilityController::class,'mpdf'])->name('manage.pre.klass.abilities.mpdf');
            Route::post('/klass/{klass}/abilities/update',[App\Http\Controllers\Manage\Pre\AbilityController::class,'update'])->name('manage.pre.klass.abilities.update');
            //Route::get('pre/theme/{theme}/student/{klassStudent}/{format?}',[App\Http\Controllers\Manage\Pre\StudentController::class,'theme'])->name('manage.pre.theme.student');
            Route::get('klass_student/{klassStudent}/theme/{theme}/{format?}',[App\Http\Controllers\Manage\Pre\ThemeController::class,'klassStudent'])->name('manage.pre.klassStudent.theme');
            Route::get('klass/{klass}/theme/{theme}/{format?}',[App\Http\Controllers\Manage\Pre\ThemeController::class,'klass'])->name('manage.pre.klass.theme');
            Route::get('klass/{klass}/themes/{format?}',[App\Http\Controllers\Manage\Pre\ThemeController::class,'klassSummary'])->name('manage.pre.klass.themes');

            Route::resource('klass/{klass}/behaviours',App\Http\Controllers\Manage\Pre\BehaviourController::class)->names('manage.pre.klass.behaviours');
            Route::get('klass/{klass}/behaviour/adjust',[App\Http\Controllers\Manage\BehaviourController::class,'adjust'])->name('manage.pre.klass.behaviour.adjust');

            Route::resource('additives',App\Http\Controllers\Manage\Pre\AdditiveController::class)->names('manage.pre.additives');
            Route::get('klass/{klass}/additive/{category}',[App\Http\Controllers\Manage\Pre\AdditiveController::class,'scope'])->name('manage.pre.klass.additive');
            Route::get('klass/{klass}/additive_page',[App\Http\Controllers\Manage\Pre\AdditiveController::class,'page'])->name('manage.pre.klass.additive.page');
            Route::get('klass/{klass}/additive_direct',[App\Http\Controllers\Manage\Pre\AdditiveController::class,'direct'])->name('manage.pre.klass.additive.direct');
            Route::post('klass/{klass}/additive_direct_input',[App\Http\Controllers\Manage\Pre\AdditiveController::class,'directInput'])->name('manage.pre.klass.additive.directInput');
    
    
        });        
});

//Route::prefix('teacher/')->group(function(){
Route::group([
    'prefix'=>'/teacher',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        'role:master|admin|director|teacher'
    ]
],function () {        
        Route::resource('/',App\Http\Controllers\Teacher\DashboardController::class);
        Route::resource('/course/{course}/behaviours',App\Http\Controllers\Teacher\BehaviourController::class)->names('teacher.course.behaviours');
        Route::get('/klass/{klass}/behaviours',[App\Http\Controllers\Teacher\BehaviourController::class,'klass'])->name('teacher.klass.behaviours');
        //Route::resource('/course',App\Http\Controllers\Teachejaon()r\CourseController::class)->names('teacher.course');
});



Route::group([
    'prefix'=>'/medical',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        'role:master|admin|director|teacher'
    ]
],function () {
    Route::get('/',[App\Http\Controllers\Medical\DashboardController::class,'index'])->name('medical');
    //Route::resource('healthcares',App\Http\Controllers\Medical\HealthcareController::class)->names('medical.healthcares');
    
    Route::get('klass/{klass}',[App\Http\Controllers\Medical\DashboardController::class,'klass'])->name('medical.klass');
    Route::resource('treatments',App\Http\Controllers\Medical\TreatmentController::class)->names('medical.treatments');
    Route::resource('healthcares',App\Http\Controllers\Medical\HealthcareController::class)->names('medical.healthcares');
    Route::get('medicnote',[App\Http\Controllers\Medical\MedicnoteController::class,'dashboard'])->name('medical.medicnote');
    Route::resource('klass/{klass}/medicnotes',App\Http\Controllers\Medical\MedicnoteController::class)->names('medical.klass.medicnotes');
    Route::resource('physicals',App\Http\Controllers\Medical\PhysicalController::class)->names('medical.physicals');
});
// Route::prefix('promote')->group(function(){
//     Route::resource('/',App\Http\Controllers\Admin\PromotionController::class);
//     Route::get('klass/{klassId}',[App\Http\Controllers\Admin\PromotionController::class,'klass']);
//     Route::get('getStudents/{klassId}',[App\Http\Controllers\Admin\PromotionController::class,'getStudents']);
//     Route::get('getPromotedStudents/{klassId}',[App\Http\Controllers\Admin\PromotionController::class,'getPromotedStudents']);
//     Route::post('updateStudents',[App\Http\Controllers\Admin\PromotionController::class,'updateStudents']);
//     Route::get('data/{yearId}',[App\Http\Controllers\Admin\PromotionController::class, 'data']);
// });

