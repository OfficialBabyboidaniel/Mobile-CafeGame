extends Node

class_name AdMob#, "res://admob-lib/icon.png"

# signals
signal banner_loaded
signal banner_failed_to_load(error_code)
signal interstitial_failed_to_load(error_code)
signal interstitial_loaded
signal interstitial_opened
signal interstitial_closed
signal interstitial_clicked
signal interstitial_impression
signal rewarded_video_opened
signal rewarded_video_loaded
signal rewarded_video_closed
signal rewarded_video_failed_to_load(error_code)
signal rewarded_interstitial_opened
signal rewarded_interstitial_loaded
signal rewarded_interstitial_closed
signal rewarded_interstitial_failed_to_load(error_code)
signal rewarded_interstitial_failed_to_show(error_code)
signal rewarded(currency, amount)
signal rewarded_clicked
signal rewarded_impression

signal consent_info_update_success
signal consent_info_update_failure(error_code, error_message)
signal consent_app_can_request_ad(consent_status)


# properties
@export var is_real:bool setget is_real_set
@export var banner_on_top:bool = true
# SMART_BANNER is deprecated
@export(String, "ADAPTIVE_BANNER", "SMART_BANNER", "BANNER", "LARGE_BANNER", "MEDIUM_RECTANGLE", "FULL_BANNER", "LEADERBOARD") var banner_size = "ADAPTIVE_BANNER"
@export var banner_id:String
@export var interstitial_id:String
@export var rewarded_id:String
@export var rewarded_interstitial_id:String
@export var child_directed:bool = false setget child_directed_set
@export var is_personalized:bool = true setget is_personalized_set
@export(String, "G", "PG", "T", "MA") var max_ad_content_rate = "G" setget max_ad_content_rate_set

# Testing consent flag
@export var ads_using_consent:bool setget ads_using_consent
@export var testing_consent:bool setget testing_consent_set


# "private" properties
var _admob_singleton = null
var _is_interstitial_loaded:bool = false
var _is_rewarded_video_loaded:bool = false
var _is_rewarded_interstitial_loaded:bool = false


func _enter_tree():
	if not init():
		print("AdMob Java Singleton not found. This plugin will only work on Android")

# setters
func is_real_set(new_val) -> void:
	is_real = new_val
# warning-ignore:return_value_discarded
	init()

func testing_consent_set(new_val) -> void:
	testing_consent = new_val

func ads_using_consent(new_val) -> void:
	ads_using_consent = new_val

func child_directed_set(new_val) -> void:
	child_directed = new_val
# warning-ignore:return_value_discarded
	init()

func is_personalized_set(new_val) -> void:
	is_personalized = new_val
# warning-ignore:return_value_discarded
	init()

func max_ad_content_rate_set(new_val) -> void:
	if new_val != "G" and new_val != "PG" \
		and new_val != "T" and new_val != "MA":

		max_ad_content_rate = "G"
		print("Invalid max_ad_content_rate, using 'G'")
	else:
		max_ad_content_rate = new_val
	init()


# initialization
func init() -> bool:
	if(Engine.has_singleton("GodotAdMob")):
		_admob_singleton = Engine.get_singleton("GodotAdMob")

		# check if one signal is already connected
		if not _admob_singleton.is_connected("on_admob_ad_loaded", self, "_on_admob_ad_loaded"):
			connect_signals()

		_admob_singleton.initWithContentRating(
			is_real,
			child_directed,
			is_personalized,
			max_ad_content_rate
		)
		return true
	return false

# connect the AdMob Java signals
func connect_signals() -> void:
	_admob_singleton.connect("on_admob_ad_loaded", self, "_on_admob_ad_loaded")
	_admob_singleton.connect("on_admob_banner_failed_to_load", self, "_on_admob_banner_failed_to_load")
	_admob_singleton.connect("on_interstitial_failed_to_load", self, "_on_interstitial_failed_to_load")
	_admob_singleton.connect("on_interstitial_opened", self, "_on_interstitial_opened")
	_admob_singleton.connect("on_interstitial_loaded", self, "_on_interstitial_loaded")
	_admob_singleton.connect("on_interstitial_close", self, "_on_interstitial_close")
	_admob_singleton.connect("on_interstitial_clicked", self, "_on_interstitial_clicked")
	_admob_singleton.connect("on_interstitial_impression", self, "_on_interstitial_impression")
	_admob_singleton.connect("on_rewarded_video_ad_loaded", self, "_on_rewarded_video_ad_loaded")
	_admob_singleton.connect("on_rewarded_video_ad_opened", self, "_on_rewarded_video_ad_opened")
	_admob_singleton.connect("on_rewarded_video_ad_closed", self, "_on_rewarded_video_ad_closed")
	_admob_singleton.connect("on_rewarded_video_ad_failed_to_load", self, "_on_rewarded_video_ad_failed_to_load")
	_admob_singleton.connect("on_rewarded_interstitial_ad_loaded", self, "_on_rewarded_interstitial_ad_loaded")
	_admob_singleton.connect("on_rewarded_interstitial_ad_opened", self, "_on_rewarded_interstitial_ad_opened")
	_admob_singleton.connect("on_rewarded_interstitial_ad_closed", self, "_on_rewarded_interstitial_ad_closed")
	_admob_singleton.connect("on_rewarded_interstitial_ad_failed_to_load", self, "_on_rewarded_interstitial_ad_failed_to_load")
	_admob_singleton.connect("on_rewarded_interstitial_ad_failed_to_show", self, "_on_rewarded_interstitial_ad_failed_to_show")
	_admob_singleton.connect("on_rewarded", self, "_on_rewarded")
	_admob_singleton.connect("on_rewarded_clicked", self, "_on_rewarded_clicked")
	_admob_singleton.connect("on_rewarded_impression", self, "_on_rewarded_impression")

	_admob_singleton.connect("on_consent_info_update_success", self, "_on_consent_info_update_success")
	_admob_singleton.connect("on_consent_info_update_failure", self, "_on_consent_info_update_failure")
	_admob_singleton.connect("on_app_can_request_ads", self, "_on_app_can_request_ads")

# load

func load_banner() -> void:
	if _admob_singleton != null:
		_admob_singleton.loadBanner(banner_id, banner_on_top, banner_size)

func load_interstitial() -> void:
	if _admob_singleton != null:
		_admob_singleton.loadInterstitial(interstitial_id)

func is_interstitial_loaded() -> bool:
	if _admob_singleton != null:
		return _is_interstitial_loaded
	return false

func load_rewarded_video() -> void:
	if _admob_singleton != null:
		_admob_singleton.loadRewardedVideo(rewarded_id)

func is_rewarded_video_loaded() -> bool:
	if _admob_singleton != null:
		return _is_rewarded_video_loaded
	return false

func load_rewarded_interstitial() -> void:
	if _admob_singleton != null:
		_admob_singleton.loadRewardedInterstitial(rewarded_interstitial_id)

func is_rewarded_interstitial_loaded() -> bool:
	if _admob_singleton != null:
		return _is_rewarded_interstitial_loaded
	return false

# show / hide

func show_banner() -> void:
	if _admob_singleton != null:
		_admob_singleton.showBanner()

func hide_banner() -> void:
	if _admob_singleton != null:
		_admob_singleton.hideBanner()

func move_banner(on_top: bool) -> void:
	if _admob_singleton != null:
		banner_on_top = on_top
		_admob_singleton.move(banner_on_top)

func show_interstitial() -> void:
	if _admob_singleton != null:
		_admob_singleton.showInterstitial()
		_is_interstitial_loaded = false

func show_rewarded_video() -> void:
	if _admob_singleton != null:
		_admob_singleton.showRewardedVideo()
		_is_rewarded_video_loaded = false

func show_rewarded_interstitial() -> void:
	if _admob_singleton != null:
		_admob_singleton.showRewardedInterstitial()
		_is_rewarded_interstitial_loaded = false

# resize

func banner_resize() -> void:
	if _admob_singleton != null:
		_admob_singleton.resize()

# dimension
func get_banner_dimension() -> Vector2:
	if _admob_singleton != null:
		return Vector2(_admob_singleton.getBannerWidth(), _admob_singleton.getBannerHeight())
	return Vector2()

func request_consent_info_update() -> void:
	if _admob_singleton != null:
		_admob_singleton.requestConsentInfoUpdate(testing_consent)

func reset_consent() -> void:
	if _admob_singleton != null:
		_admob_singleton.resetConsentInformation()

# callbacks

func _on_admob_ad_loaded() -> void:
	emit_signal("banner_loaded")

func _on_admob_banner_failed_to_load(error_code:int) -> void:
	emit_signal("banner_failed_to_load", error_code)

func _on_interstitial_failed_to_load(error_code:int) -> void:
	_is_interstitial_loaded = false
	emit_signal("interstitial_failed_to_load", error_code)

func _on_interstitial_opened() -> void:
	emit_signal("interstitial_opened")

func _on_interstitial_loaded() -> void:
	_is_interstitial_loaded = true
	emit_signal("interstitial_loaded")

func _on_interstitial_close() -> void:
	emit_signal("interstitial_closed")

func _on_interstitial_clicked() -> void:
	emit_signal("interstitial_clicked")

func _on_interstitial_impression() -> void:
	emit_signal("interstitial_impression")

func _on_rewarded_video_ad_loaded() -> void:
	_is_rewarded_video_loaded = true
	emit_signal("rewarded_video_loaded")

func _on_rewarded_video_ad_opened() -> void:
	emit_signal("rewarded_video_opened")

func _on_rewarded_video_ad_closed() -> void:
	emit_signal("rewarded_video_closed")

func _on_rewarded_video_ad_failed_to_load(error_code:int) -> void:
	_is_rewarded_video_loaded = false
	emit_signal("rewarded_video_failed_to_load", error_code)

func _on_rewarded_interstitial_ad_opened() -> void:
	emit_signal("rewarded_interstitial_opened")

func _on_rewarded_interstitial_ad_loaded() -> void:
	_is_rewarded_interstitial_loaded = true
	emit_signal("rewarded_interstitial_loaded")

func _on_rewarded_interstitial_ad_closed() -> void:
	emit_signal("rewarded_interstitial_closed")

func _on_rewarded_interstitial_ad_failed_to_load(error_code:int) -> void:
	_is_rewarded_interstitial_loaded = false
	emit_signal("rewarded_interstitial_failed_to_load", error_code)

func _on_rewarded_interstitial_ad_failed_to_show(error_code:int) -> void:
	_is_rewarded_interstitial_loaded = false
	emit_signal("rewarded_interstitial_failed_to_show", error_code)

func _on_rewarded(currency:String, amount:int) -> void:
	emit_signal("rewarded", currency, amount)

func _on_rewarded_clicked() -> void:
	emit_signal("rewarded_clicked")

func _on_rewarded_impression() -> void:
	emit_signal("rewarded_impression")

func _on_consent_info_update_success() -> void:
	emit_signal("consent_info_update_success")
	
func _on_consent_info_update_failure(error_code:int, error_message:String) -> void:
	emit_signal("consent_info_update_failure", error_code, error_message)
	
func _on_app_can_request_ads(consent_status:int) -> void:
	emit_signal("consent_app_can_request_ad", consent_status)
