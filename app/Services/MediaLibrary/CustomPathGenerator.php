<?php

namespace App\Services\MediaLibrary;

use \Spatie\MediaLibrary\MediaCollections\Models\Media;
use Spatie\MediaLibrary\Support\PathGenerator\PathGenerator as BasePathGenerator;
use App\Models\Year;
use App\Models\KlassStudent;

class CustomPathGenerator implements BasePathGenerator
{
    /**
     * Get the path for the given media, relative to the root storage path.
     *
     * @param \Spatie\MediaLibrary\MediaCollections\Models\Media $media
     *
     * @return string
     */
    public function getPath(Media $media): string
    {
        switch($media->model_type){
            case KlassStudent::class:
                $klassStudent=KlassStudent::find($media->model_id);
                return $klassStudent->klass->grade->year->code.DIRECTORY_SEPARATOR.$klassStudent->klass->tag.DIRECTORY_SEPARATOR.$media->id.DIRECTORY_SEPARATOR;
                break;
            default:
                return $media->id.DIRECTORY_SEPARATOR;
        };
    }

    /**
     * Get the path for conversions of the given media, relative to the root storage path.
     *
     * @param \Spatie\MediaLibrary\MediaCollections\Models\Media $media
     *
     * @return string
     */
    public function getPathForConversions(Media $media): string
    {
        switch($media->model_type){
            case KlassStudent::class:
                $klassStudent=KlassStudent::find($media->model_id);
                return $klassStudent->klass->grade->year->code.DIRECTORY_SEPARATOR.$klassStudent->klass->tag.DIRECTORY_SEPARATOR.$media->id.'/conversions/';
                break;
            default:
                return $media->id.DIRECTORY_SEPARATOR;
        };

    }

    /**
     * Get the path for responsive images of the given media, relative to the root storage path.
     *
     * @param \Spatie\MediaLibrary\MediaCollections\Models\Media $media
     *
     * @return string
     */
    public function getPathForResponsiveImages(Media $media): string
    {
        switch($media->model_type){
            case KlassStudent::class:
                $klassStudent=KlassStudent::find($media->model_id);
                return $klassStudent->klass->grade->year->code.DIRECTORY_SEPARATOR.$klassStudent->klass->tag.DIRECTORY_SEPARATOR.$media->id.'/responsive-images/';
                break;
            default:
                return $media->id.DIRECTORY_SEPARATOR;
        };

    }
}