extends Node
## The [SignalBus] can be used to provide global signals.
## Use normal signals for child to parent communication, use global signals otherwise.
## [br][br]
## Original File MIT License Copyright (c) 2024 TinyTakinTeller

# Configuration
signal language_changed(locale: String)
signal number_format_changed(number_format: NumberUtils.NumberFormat)
signal delete_path(path: Path)

# Game
signal clicks_per_second_updated(cps: int)

#region In-level

signal lvl_mode_changed(new_mode : LevelActionListener.CLICK_MODE)

signal lvl_pet_filter_cycle_favourite
signal lvl_pet_filter_cycle_tribe
signal lvl_pet_filter_cycle_affinity
signal lvl_pet_filter_reset
signal lvl_pet_filter_changed(favourites : bool, tribe : int, affinity : int)

signal lvl_pet_pick(posn : int)
signal lvl_pet_result(pet : PetRegistryData)

#endregion
