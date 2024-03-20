<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphMany;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;
use Spatie\MediaLibrary\MediaCollections\Models\Media;
use Spatie\Image\Manipulations;


class KlassStudent extends Model implements HasMedia
{
    use HasFactory;
    use InteractsWithMedia;
    protected $table='klass_student';
    protected $fillable=['promote_to'];

    public function registerMediaConversions(Media $media = null): void
    {
        $this
            ->addMediaConversion('preview')
            ->fit(Manipulations::FIT_CROP, 300, 300)
            ->nonQueued();
    }
    public function registerMediaCollections(): void
    {
        $this->addMediaCollection('avatar')
            ->singleFile()
            ->useDisk('profile');
        $this->addMediaCollection('transcript')
            ->singleFile()
            ->useDisk('profile');
    }         

    public function student(){
        return $this->belongsTo(Student::class);
    }

    public function behaviours(){
        return $this->hasMany(Behaviour::class);
    }
    public function klass(){
        return $this->belongsTo(Klass::class)->with('grade');
    }
    public function habits(){
        return $this->hasMany(Habit::class);
    }
    public function avatar(){
        return $this->getMedia('avatar');
    }

    public function archives(){
        return $this->morphMany(Archive::class, 'archivable');
    }

}
