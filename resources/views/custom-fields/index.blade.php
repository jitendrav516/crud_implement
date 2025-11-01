@extends('layouts.app')

@section('content')
<div class="container">
    <h2>Custom Fields</h2>
    <a href="{{ route('custom-fields.create') }}" class="btn btn-success mb-3">Add New Field</a>

    @if(session('success'))
        <div class="alert alert-success">{{ session('success') }}</div>
    @endif

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Label</th>
                <th>Field Key</th>
                <th>Type</th>
                <th>Options (If Select)</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            @foreach($fields as $field)
                <tr>
                    <td>{{ $field->label }}</td>
                    <td>{{ $field->field_key }}</td>
                    <td>{{ $field->type }}</td>
                    <td>
                        @if(is_array($field->options))
                            {{ implode(', ', $field->options) }}
                        @endif
                    </td>
                    <td>
                        <a href="{{ route('custom-fields.edit', $field->id) }}" class="btn btn-primary btn-sm">Edit</a>
                        <form action="{{ route('custom-fields.destroy', $field->id) }}" method="POST" style="display:inline-block;">
                            @csrf @method('DELETE')
                            <button onclick="return confirm('Delete this field?')" class="btn btn-danger btn-sm">Delete</button>
                        </form>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection
