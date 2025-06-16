<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;
use Nexmo\Laravel\Facade\Nexmo;

class UserActionNotification extends Notification implements ShouldQueue
{
    use Queueable;
    protected $action;
    protected $url;
    protected $template;
    protected $channels;
    /**
     * Create a new notification instance.
     */
    public function __construct($action, $url=null, $template='generalEmail', $channels=['mail'])
    {
        $this->action = $action;
        $this->url=$url;
        $this->template=$template;
        $this->channels=$channels;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        //return ['mail', 'database', 'sms']; // Assuming you're using Nexmo for SMS //nexmo
        return array_unique(array_merge(['database'], $this->channels));

    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
            ->subject('New User Action')
            ->view('notifications/'.$this->template,[
                'title'=>'Action Notification',
                'content'=>'Content body: A user has performed an action ',
                'url'=>$this->url,
            ])
            ->line('A user has performed an action: ' . $this->action)
            ->action('View Action', url('/actions'))
            ->line('Thank you for using our application!');
    }
        // Database notification
    public function toDatabase($notifiable)
    {
        return [
            'action' => $this->action,
            'created_at' => now(),
        ];
    }

    public function toSms($notifiable)
    {
        // Example API integration
        $apiUrl = 'https://your-local-telco-api.com/send-sms';
        $apiKey = 'YOUR_API_KEY';
        $phoneNumber = $notifiable->phone;

        $data = [
            'to' => $phoneNumber,
            'message' => 'A user has performed an action: ' . $this->action,
        ];

        // Send the SMS using cURL
        $ch = curl_init($apiUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, array_merge($data, ['api_key' => $apiKey]));

        $response = curl_exec($ch);
        curl_close($ch);

        // Optionally, handle the response (success/failure)
        return $response;
    }
    
    // SMS notification using Nexmo
    public function toNexmo($notifiable)
    {
        return Nexmo::message()->send([
            'to' => $notifiable->phone,
            'from' => config('nexmo.sms_from'), // Your Nexmo number
            'text' => 'A user has performed an action: ' . $this->action,
        ]);

    }

    // Optionally, you can define a method to log the notification


    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            //
        ];
    }
}
