<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use \App\Http\Resources\PinjamanResource;
use \App\Http\Resources\StudentResource;
use App\Models\Pinjaman as PinjamanModel;
use App\Models\Student as StudentModel;
use DB;

class ApiPinjamanController extends Controller
{
    public function index(Request $request)
    {
        $data = PinjamanModel::with('student')
                                ->paginate(
                                    $perPage = $request->perPage, $columns = ['*'], 'page', $request->pageSelect
                                );

        return PinjamanResource::collection($data);
    }

    public function kembalian(Request $request)
    {
        $data = PinjamanModel::with('student')
                ->paginate(
                    $perPage = $request->perPage, $columns = ['*'], 'page', $request->pageSelect
                );

        return PinjamanResource::collection($data);
    }

    public function update(Request $request)
    {
        $data_update = [
            'tanggal_kembali' => now(),
            'status'     => 0
        ];

        $query = PinjamanModel::where('id', $request->id)->update($data_update);

        if($query)
        {
            $data = PinjamanModel::with('student')
                                ->paginate(
                                    $perPage = $request->perPage, $columns = ['*'], 'page', $request->pageSelect
                                );

            return PinjamanResource::collection($data);
        } 
        else 
        {
            return response([
                "message" => "failed update data",
                "status_code" => 500
             ], 500);
        }
    }

    public function delete(Request $request)
    {
        
        $result=PinjamanModel::where('id',$request->id)->delete();
        if($request)
        {
            $data = PinjamanModel::with('student')
                                ->paginate(
                                    $perPage = $request->perPage, $columns = ['*'], 'page', $request->pageSelect
                                );

            return PinjamanResource::collection($data);
        }
        else
        {
            return response([
                "message" => "failed insert data",
                "status_code" => 500
                ], 500);
        }
    }
}
