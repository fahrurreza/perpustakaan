<?php

use Illuminate\Support\Facades\Route;
use App\Http\Livewire\Livewire;

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


//Menu
Route::get('/sistem-menu', 'MenuController@index')->name('menu');
Route::get('/sistem-unit', 'UnitController@index')->name('unit');

Route::get('/tes', 'API\ApiMenuController@tes');
//API Local