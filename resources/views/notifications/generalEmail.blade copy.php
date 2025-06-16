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
    <h1>{{ $title }}</h1>
    {{-- <p>{{ $message }}</p> --}}
    <a href="{{ $url }}" class="button">View Action</a>
    <p>Thank you for using our application!</p>
</body>
</html>