<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Student as StudentModel;
use App\Models\Book as BookModel;
use \App\Http\Resources\BookResource;
use App\Models\Pinjaman as PinjamanModel;
use Toastr;
use Auth;
use Illuminate\Support\Carbon;
use PDF;

class PinjamanController extends Controller
{
    public function index()
    {
        $data = [
            'page'  => 'Pinjaman',
            'student' => StudentModel::where('status', true)->get(),
            'book' => BookModel::with('stock')->where('status', true)->get(),
        ];
        return view('pinjaman.index', compact('data'));
    }

    public function kembalian()
    {
        $data = [
            'page'  => 'Buku Di Kembalikan'
        ];
        return view('pinjaman.kembalian', compact('data'));
    }

    public function store (Request $request)
    {
        
        $check = PinjamanModel::where('student_id', $request->student_id)
                                ->where('book_id', $request->book_id)
                                ->where('status', true)
                                ->count();

                                    
        if($check > 0){
            Toastr::warning('Buku sudah di pinjam dan belum dikembalikan, cek data pinjaman siswa!');
            return back();
        }

        
        $data_insert = [
            'book_id'           => $request->book_id,
            'book_code'       => $request->no_buku,
            'student_id'        => $request->student_id,
            'jumlah'            => 1,
            'tanggal_dipinjam'  => now(),
            'batas_dipinjam'    => $request->batas_pinjam,
            'tanggal_kembali'   => null,
            'status'            => true,
            'user_id'           => 1,
            'created_at'        => now(),
            'updated_at'        => null
        ];
        

        $insert = PinjamanModel::create($data_insert);

        if($insert)
        {
            Toastr::success('Berhasil!');
            return back();
        } 
        else 
        {
            Toastr::success('Gagal!');
            return back();
        }

    }

    public function pinjaman_siswa()
    {
        $data_student = StudentModel::where('user_id',  Auth::user()->id)->first();
        $student_id = $data_student->id;
        $data = [
            'page'          => 'Data Pinajaman',
            'pinjaman'      => PinjamanModel::with(['book'])->where('student_id', $student_id)->get()
        ];
        return view('pinjaman.pinjaman_siswa', compact('data'));
    }

    public function laporan_pinjaman()
    {
        $data = [
            'page'      => 'Data Pinjaman',
            'pinjaman'  => null
        ];

        return view('pinjaman.laporan', compact('data'));
    }

    public function laporan_bulanan(Request $request)
    {
        $time       = strtotime($request->periode);
        $month      = date("m",$time);
        $year       = date("Y",$time);
        $periode    = $year.'-'.$month;

        $data = [
            'page'          => 'Data Pinjaman',
            'pinjaman'      => PinjamanModel::with(['book', 'student'])->whereMonth('tanggal_dipinjam', $month)->whereYear('tanggal_dipinjam', $year)->get(),
            'periode'       => $periode
        ];
        
        return view('pinjaman.laporan', compact('data'));
    }

    public function cetak_laporan($periode)
    {
        $dateStr    = '2023-07-31';
        $year       = date('Y', strtotime($dateStr));
        $month      = date('m', strtotime($dateStr));;

        $data = [
            'page'          => 'Data Pinjaman',
            'pinjaman'      => PinjamanModel::with(['book', 'student'])->whereMonth('tanggal_dipinjam', $month)->whereYear('tanggal_dipinjam', $year)->get()
        ];
        
        $pdf = PDF::loadView('pinjaman.cetak', compact('data'));

        return $pdf->stream('document.pdf');
    }
}
