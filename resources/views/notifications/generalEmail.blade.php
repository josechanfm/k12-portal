<!-- resources/views/vendor/notifications/custom-email.blade.php -->
<!DOCTYPE html>
<html>
<head>
    <title>{{ $subject }}</title>
    <style>
        /* Add your custom styles here */
        body { font-family: Arial, sans-serif; }
        .button {
            display: inline-block;
            padding: 10px 20px;
            color: white;
            background-color: #007bff;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    @if (! empty($title))
        <h1>{{ $title }}</h1>
    @endif

    @if (! empty($content))
        <p>{{ $content }}</p>
    @endif
    
    {{-- Intro Lines --}}
    @foreach ($introLines as $line)
        {{ $line }}
    @endforeach

    @isset($actionText)
        <a href="{{ $actionUrl }}" class="button">{{ $actionText }}</a>
    @endisset


    {{-- Outro Lines --}}
    @foreach ($outroLines as $line)
        {{ $line }}

    @endforeach

    {{-- Salutation --}}
    @if (! empty($salutation))
    {{ $salutation }}
    @else

    @lang('Regards'),<br>
    {{ config('app.name') }}
    @endif


</body>
</html>