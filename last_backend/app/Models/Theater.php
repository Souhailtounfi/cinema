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

    //ngenerer seats f kol theater 
    public function generateSeats()
    {
        $capacity = $this->capacity;
        $seatsPerRow = 15;
        $rowLetters = range('A', 'Z'); // Up to 26 rows (390 seats max)

        $totalSeats = 0;
        $rowIndex = 0;

        while ($totalSeats < $capacity && $rowIndex < count($rowLetters)) {
            for ($seatNum = 1; $seatNum <= $seatsPerRow && $totalSeats < $capacity; $seatNum++) {
                $this->seats()->create([
                    'seat_number' => $rowLetters[$rowIndex] . $seatNum
                ]);
                $totalSeats++;
            }
            $rowIndex++;
        }
    }

}