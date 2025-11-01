@extends('layouts.app')

@section('title', 'Edit Custom Field')

@section('content')
<div class="card">
    <div class="card-header">
        <h4>Edit Custom Field</h4>
    </div>
    <div class="card-body">

        <form action="{{ route('custom-fields.update', $field->id) }}" method="POST">
            @csrf
            @method('PUT')

            <div class="mb-3">
                <label>Label</label>
                <input type="text" name="label" class="form-control" value="{{ $field->label }}" required>
            </div>

            <div class="mb-3">
                <label>Field Key (cannot change)</label>
                <input type="text" class="form-control" value="{{ $field->field_key }}" disabled>
            </div>

            <div class="mb-3">
                <label>Type</label>
                <select name="type" class="form-control" required>
                    <option value="text" {{ $field->type=='text'?'selected':'' }}>Text</option>
                    <option value="number" {{ $field->type=='number'?'selected':'' }}>Number</option>
                    <option value="date" {{ $field->type=='date'?'selected':'' }}>Date</option>
                    <option value="select" {{ $field->type=='select'?'selected':'' }}>Select</option>
                    <option value="textarea" {{ $field->type=='textarea'?'selected':'' }}>Textarea</option>
                </select>
            </div>

            <div class="mb-3">
                <label>Options (only for select type, comma separated)</label>
                <input type="text" name="options" class="form-control"
                       value="{{ $field->options ? implode(',', $field->options) : '' }}">
            </div>

            <button type="submit" class="btn btn-primary">Update</button>
            <a href="{{ route('custom-fields.index') }}" class="btn btn-secondary">Back</a>
        </form>

    </div>
</div>
@endsection
