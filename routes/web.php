<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ContactController; // task_pro/app/Http/Controllers/ContactController.php
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
    return view('welcome');
});


Route::get('contacts', [App\Http\Controllers\ContactController::class,'index'])->name('contacts.index');
Route::post('contacts/store', [App\Http\Controllers\ContactController::class,'store'])->name('contacts.store');
Route::post('contacts/{contact}/update', [App\Http\Controllers\ContactController::class,'update'])->name('contacts.update');
Route::delete('contacts/{contact}', [App\Http\Controllers\ContactController::class,'destroy'])->name('contacts.destroy');

// endpoints for custom field admin (optional)
Route::resource('custom-fields', App\Http\Controllers\CustomFieldDefinitionController::class);
Route::get('contacts/{contact}/json', [ContactController::class,'showJson']);


// Merge endpoints
Route::get('contacts/{contact}/merge-modal', [App\Http\Controllers\ContactController::class,'mergeModal'])->name('contacts.merge.modal');
Route::post('contacts/merge', [App\Http\Controllers\ContactController::class,'merge'])->name('contacts.merge');
Route::get('contacts/{contact}/possible-masters', [App\Http\Controllers\ContactController::class,'possibleMasters'])->name('contacts.possible_masters');
Route::get('contacts/{contact}/merge-logs', [App\Http\Controllers\ContactController::class,'mergeLogs'])->name('contacts.merge_logs');