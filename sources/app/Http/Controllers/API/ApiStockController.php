<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use \App\Http\Resources\StockResource;
use App\Models\Stock as StockModel;

class ApiStockController extends Controller
{
    public function index(Request $request)
    {
        $query = StockModel::where($request->column, 'LIKE', '%' . $request->keyword . '%')
                            ->paginate(
                                $perPage = $request->perPage, $columns = ['*'], 'page', $request->pageSelect
                            );
        $stock = StockResource::collection($query);

        return $stock;
    }

    public function update(Request $request)
    {
        $data_update = [
            'stock'   => $request->stock
        ];

        $query = StockModel::where('id', $request->id)->update($data_update);

        if($query)
        {
            $query = StockModel::where('book_id', 'LIKE', '%' . $request->keyword . '%')
                                ->paginate(
                                    $perPage = 10, $columns = ['*'], 'page', 1
                                );
            $stock = StockResource::collection($query);

            return $stock;
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
       
        $result=StockModel::where('id',$request->id)->delete();
        if($request)
        {
            $query = StockModel::where($request->column, 'LIKE', '%' . $request->keyword . '%')
                                ->paginate(
                                    $perPage = $request->perPage, $columns = ['*'], 'page', $request->pageSelect
                                );
            $stock = StockResource::collection($query);

            return $stock;
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
