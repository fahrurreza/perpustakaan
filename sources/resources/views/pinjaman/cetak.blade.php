<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>PERPUS SMAN-1 BANGUN PURBA</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="{{asset('assets/bower_components/bootstrap/dist/css/bootstrap.min.css')}}">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="{{asset('assets/bower_components/font-awesome/css/font-awesome.min.css')}}">
  <!-- Ionicons -->
  <link rel="stylesheet" href="{{asset('assets/bower_components/Ionicons/css/ionicons.min.css')}}">
  <!-- Theme style -->
  <link rel="stylesheet" href="{{asset('assets/dist/css/AdminLTE.min.css')}}">
  <!-- iCheck -->
  <link rel="stylesheet" href="{{asset('assets/plugins/iCheck/square/blue.css')}}">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="container">
        <div class="title">
            <h3 class="text-center"> LAPORAN PEMINJAMAN BUKU  </h3>
            <h3 class="text-center"> PERPUSTAKAAN SMA NEGERI 1 BANGUN PURBA  </h3>
        </div>
        <div class="table">
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
              </table>
              <div class="ttd" style="float: right; text-align: right;">
                <p>Bangun Purba, …………….2023</p>
                <p style="margin-right:135px; padding-top:-10px">Diketahui</p>
                <p style="margin-right:55px; padding-top:-10px">Petugas Perpustakaan</p>
                <p style="margin-top:55px">……………………………………….</p>
              </div>
        </div>
    </div>

<!-- jQuery 3 -->
<script src="{{asset('assets/bower_components/jquery/dist/jquery.min.js')}}"></script>
<!-- Bootstrap 3.3.7 -->
<script src="{{asset('assets/bower_components/bootstrap/dist/js/bootstrap.min.js')}}"></script>
<!-- iCheck -->
<script src="{{asset('assets/plugins/iCheck/icheck.min.js')}}"></script>
<script>
  $(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' /* optional */
    });
  });
</script>
</body>
</html>
