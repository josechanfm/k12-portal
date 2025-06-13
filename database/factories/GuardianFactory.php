<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Student>
 */
class GuardianFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'name_zh' => $this->faker->name,
            'name_en' => $this->faker->firstname,
            'gender' => $this->faker->randomElement(['M','F']),
            'dob' => $this->faker->dateTimeBetween('1970-09-01','2000-09-01')->format('Y-m-d'),
        ];
    }
}
