extends Label

func play_animation(num):
	show()
	$AnimationPlayer.play('.')
	text = str(num)
	if num == 0:
		text = 'GO!'
		$HighBeepSound.play()
		yield($AnimationPlayer, 'animation_finished')
		$AnimationPlayer.play('Disappear')
	else:
		$BeepSound.play()