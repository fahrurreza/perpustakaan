<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use \App\Http\Resources\MenuResource;
use App\Models\Menu as MenuModel;

class ApiMenuController extends Controller
{
    public function index(Request $request)
    {
        
        $query = MenuModel::where($request->column, 'LIKE', '%' . $request->keyword . '%')
                            ->paginate(
                                $perPage = $request->perPage, $columns = ['*'], 'page', $request->pageSelect
                            );
        $menus = MenuResource::collection($query);

        return $menus;
    }

    public function store (Request $request)
    {
       
        if($request->type == 'MAIN_MENU')
        {
            $code_key = 'MM';
        }
        elseif($request->type == 'SUB_MENU')
        {
            $code_key = 'SM';
        }
        else {
            $code_key = 'A';
        }

        $str = $request->label;
        $capital = strtoupper($str);
        $menu_key = str_replace(" ", "_", $capital);

        $data_insert = [
            'parent_id'     => $request->parent_id,
            'type'          => $request->type,
            'menu_key'      => $menu_key,
            'label'         => $request->label,
            'route'         => $request->link,
            'icon'          => $request->icon,
            'short_order'   => $request->short_order,
            'status'        => $request->status,
            'created_at'    => now(),
        ];

        $insert = MenuModel::create($data_insert);

        if($insert)
        {
            $query = MenuModel::where('label', 'LIKE', '%' . $request->keyword . '%')
                                ->paginate(
                                    $perPage = 10, $columns = ['*'], 'page', 1
                                );
            $menus = MenuResource::collection($query);

            return $menus;
        } 
        else 
        {
            return response([
                "message" => "failed insert data",
                "status_code" => 500
                ], 500);
        }
    }

    public function show(Request $request)
    {
        $query = MenuModel::where('id', '=', $request->id)->first();

        return $query;
    }

    public function update(Request $request)
    {
        if($request->type == 'MAIN_MENU')
        {
            $code_key = 'MM';
        }
        elseif($request->type == 'SUB_MENU')
        {
            $code_key = 'SM';
        }
        else {
            $code_key = 'A';
        }

        $str = $request->label;
        $capital = strtoupper($str);
        $menu_key = str_replace(" ", "_", $capital);

        $data_update = [
            "parent_id" => $request->parent_id,
            "type" => $request->type,
            "menu_key" => $menu_key,
            "label" => $request->label,
            "route" => $request->link,
            "icon" => $request->icon,
            "short_order" => $request->short_order,
            "status" => $request->status,
            "updated_at" => now()
        ];

        $query = MenuModel::where('id', $request->id)->update($data_update);

        if($query)
        {
            $query = MenuModel::where('label', 'LIKE', '%' . $request->keyword . '%')
                                ->paginate(
                                    $perPage = 10, $columns = ['*'], 'page', 1
                                );
            $menus = MenuResource::collection($query);

            return $menus;
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
        
        $result=MenuModel::destroy($request->id);
        if($request)
        {
            $query = MenuModel::where($request->column, 'LIKE', '%' . $request->keyword . '%')
                                ->paginate(
                                    $perPage = $request->perPage, $columns = ['*'], 'page', $request->pageSelect
                                );
            $menus = MenuResource::collection($query);

            return $menus;
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
