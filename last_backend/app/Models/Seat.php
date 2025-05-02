<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Seat extends Model
{
    protected $fillable = ['theater_id', 'seat_row', 'seat_number'];

    public function theater()
    {
        return $this->belongsTo(Theater::class);
    }
}
