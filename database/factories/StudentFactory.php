<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Student>
 */
class StudentFactory extends Factory
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
            'name_fn' => $this->faker->firstname,
            'gender' => $this->faker->randomElement(['M','F']),
            'dob' => $this->faker->dateTimeBetween('2000-09-01','2015-09-01')->format('Y-m-d'),
        ];
    }
}
