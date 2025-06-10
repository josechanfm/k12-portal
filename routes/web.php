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

});



Route::group([
    'prefix'=>'/student',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        ]
],function () {
    Route::get('/', function () {
        dd('student');
    })->name('student');

});

require __DIR__ . '/auth.php';