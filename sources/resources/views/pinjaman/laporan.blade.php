@extends('layouts.app')

@section('content')


@push('custom-style')
<link rel="stylesheet" href="assets/toastr/toastr.min.css">
<script src="assets/sweetalert/xsweetalert.css"></script>
<link rel="stylesheet" href="assets/bower_components/select2/dist/css/select2.min.css">
<script src="assets/bower_components/select2/dist/js/select2.full.min.js"></script>
@endpush

<section class="content" id="app">
  <div>
    <div class="box box-info">
      <div class="box-header">
        <h3 class="box-title">Laporan Data Pinjaman Bulanan</h3>
      </div>
      <div class="box-body">
        <div class="row">
          <form action="{{route('lihat-laporan')}}" method="post">
            @csrf
            <div class="col-sm-5">
              <input type="month" class="form-control" id="periode" name="periode" placeholder="Periode Awal">
            </div>
            <div class="col-sm-2">
              <button class="btn btn-primary">Lihat Laporan</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    @if($data['pinjaman'] != null)
    <div class="box box-info">
      <div class="box-header">
        <h3 class="box-title">Data Laporan Peminjam</h3>
      </div>
      <div class="box-body table-responsive">
        <div id="datatable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
          <div class="row">
            <div class="col-sm-6">
              <a class="btn btn-warning" href="{{url('cetak-laporan/'.$data['periode'])}}">Cetak</a>
            </div>
          </div>
          <div class="row" style="margin-top:10px;">
            <div class="col-sm-12">
              <table id="datatable" class="table table-bordered table-striped">
                <thead>
                  <tr role="row" class="bg-gray">
                    <th class="text-center">No.</th>
                    <th>Nama Siswa</th>
                    <th>NIS</th>
                    <th>Buku Yang Dipinjam</th>
                    <th>No Buku</th>
                    <th>Tanggal Peminjaman</th>
                    <th>Tanggal Dikembalikan</th>
                  </tr>
                </thead>
                <tbody>
                  @foreach($data['pinjaman'] as $list)
                  <tr>
                    <td>{{$loop->iteration}}</td>
                    <td>{{$list->student->nama_siswa}}</td>
                    <td>{{$list->student->nis}}</td>
                    <td>{{$list->book->book_name}}</td>
                    <td>{{$list->book_code}}</td>
                    <td>{{$list->tanggal_dipinjam}}</td>
                    <td>{{$list->tanggal_kembali}}</td>
                  </tr>
                  @endforeach
                </tbody>
                <tfoot>
                  <tr role="row" class="bg-gray">
                    <th class="text-center">No.</th>
                    <th>Nama Siswa</th>
                    <th>NIS</th>
                    <th>Buku Yang Dipinjam</th>
                    <th>No Buku</th>
                    <th>Tanggal Peminjaman</th>
                    <th>Tanggal Dikembalikan</th>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
          
        </div>
      </div><!-- /.box-body -->
    </div>
    @endif
  </div>
</section>

@endsection

@push('custom-scripts')
<script src="assets/vue/vue.js"></script>
<script src="assets/vue/table.js"></script>
<script src="assets/vue/axios.js"></script>
<script src="assets/sweetalert/xsweetalert.js"></script>
<script src="assets/toastr/toastr.min.js"></script>
<script src="assets/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="assets/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script src="assets/js/page/app.js"></script>
<script src="assets/js/notif.js"></script>
@endpush