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
        <h3 class="box-title">Data Pinjaman {{Auth::user()->nama_lengkap}}</h3>
      </div>
      <div class="box-body table-responsive">
        <div id="datatable_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
          <div class="row">
            <div class="col-sm-12">
              <table id="datatable" class="table table-bordered table-striped">
                @if(count($data['pinjaman']) < 1)
                <span>Belum ada meminjam buku</span>
                @else
                <thead>
                  <tr role="row" class="bg-gray">
                    <th class="text-center">No.</th>
                    <th>No Buku</th>
                    <th>Buku</th>
                    <th>Batas Tanggal</th>
                    <th>Tanggal Pinjam</th>
                    <th>Tanggal Dikembalikan</th>
                  </tr>
                </thead>
                <tbody>
                    @foreach($data['pinjaman'] as $list)
                    <tr>
                        <td>{{$loop->iteration}}</td>
                        <td>{{$list->book_code}}</td>
                        <td>{{$list->book->book_name}}</td>
                        <td>{{$list->batas_dipinjam}}</td>
                        <td>{{$list->tanggal_dipinjam}}</td>
                        <td>{{$list->tanggal_kembali}}</td>
                    </tr>
                    @endforeach
                </tbody>
                <tfoot>
                  <tr role="row" class="bg-gray">
                    <th class="text-center">No.</th>
                    <th>No Buku</th>
                    <th>Buku</th>
                    <th>Batas Tanggal</th>
                    <th>Tanggal Pinjam</th>
                    <th>Tanggal Dikembalikan</th>
                  </tr>
                </tfoot>
                @endif
              </table>
            </div>
          </div>
        </div>
      </div><!-- /.box-body -->
    </div>
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