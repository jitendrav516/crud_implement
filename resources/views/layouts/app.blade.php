<!DOCTYPE html>
<html>
<head>
    <title>@yield('title', 'CRM')</title>

    <meta name="csrf-token" content="{{ csrf_token() }}">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">

    @yield('styles')
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-3">
    <div class="container">
        {{-- <a class="navbar-brand" href="#">INTRICARE</a> --}}
        <a class="navbar-brand" href="#" style="font-family: auto;font-size: 27px;font-weight: 600;">INTRICARE</a>
        <div>
            <a href="{{ url('/contacts') }}" class="btn btn-light btn-sm">Contacts</a>
            <a href="{{ url('/custom-fields') }}" class="btn btn-light btn-sm">Custom Fields</a>
        </div>
    </div>
</nav>

<div class="container">
    @yield('content')
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>

@yield('scripts')
</body>
</html>
