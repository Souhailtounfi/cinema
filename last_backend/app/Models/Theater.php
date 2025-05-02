<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Theater extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'capacity',
    ];

    protected static function booted()
    {
        static::created(function ($theater) {
            $theater->generateSeats();
        });
    }

    public function showtimes()
    {
        return $this->hasMany(Showtime::class);
    }

    public function seats()
    {
        return $this->hasMany(Seat::class);
    }

    public function generateSeats()
    {
        $capacity = $this->capacity;
        $rows = $this->calculateOptimalRows($capacity);
        $seatsPerRow = ceil($capacity / $rows);
        
        $totalSeats = 0;
        $rowLetters = range('A', 'Z'); // Support up to 26 rows

        for ($i = 0; $i < $rows && $totalSeats < $capacity; $i++) {
            for ($seatNum = 1; $seatNum <= $seatsPerRow && $totalSeats < $capacity; $seatNum++) {
                $this->seats()->create([
                    'seat_row' => $rowLetters[$i],
                    'seat_number' => $seatNum
                ]);
                $totalSeats++;
            }
        }
    }

    protected function calculateOptimalRows($capacity)
    {
        // Calculate base rows (15 seats per row)
        $baseRows = ceil($capacity / 15);
        
        // Constrain between 10-15 rows
        return max(10, min(15, $baseRows));
    }
}