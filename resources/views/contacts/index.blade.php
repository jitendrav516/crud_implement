@extends('layouts.app')

@section('content')
@include('contacts.partials.merge_modal')

<div class="container">
  <h1>Contacts</h1>

  <div class="row mb-3">
    <div class="col-md-3"><input id="filterName" class="form-control" placeholder="Name"></div>
    <div class="col-md-3"><input id="filterEmail" class="form-control" placeholder="Email"></div>
    <div class="col-md-2">
      <select id="filterGender" class="form-control">
        <option value="">All genders</option>
        <option value="male">Male</option>
        <option value="female">Female</option>
        <option value="other">Other</option>
      </select>
    </div>
    <div class="col-md-2">
      <button id="btnFilter" class="btn btn-secondary">Filter</button>
      <button id="btnReset" class="btn btn-light">Reset</button>
    </div>
    <div class="col-md-2 text-end">
      <button id="btnNew" class="btn btn-success">New Contact</button>
    </div>
  </div>

  <div id="contactsTable">
    @include('contacts.partials.table', ['contacts' => $contacts])
  </div>
</div>

@include('contacts.partials.modal') {{-- create/edit modal, see below --}}
@endsection

@section('scripts')
<script>
$.ajaxSetup({ headers: { 'X-CSRF-TOKEN': '{{ csrf_token() }}' } });
</script>
<script src="{{ asset('js/contacts.js') }}"></script>
@endsection
