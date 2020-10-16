"
A TSLabelTest is a test class for testing the behavior of TSLabel
"
Class {
	#name : #RSLabelTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #running }
RSLabelTest >> setUp [
	super setUp.
	canvas := RSCanvas new
]

{ #category : #tests }
RSLabelTest >> testCairoFitMetricsProvider [
	| label h |
	label := RSLabel new.
	label text: '.'.
	h := label height.
	label metricsProvider: (RSCairoFitMetricsProvider new).
	self assert: h > label height.
]

{ #category : #tests }
RSLabelTest >> testCairoFitMetricsProviderOnUnicodeGlyphs [

	"This test case collects unicode symbols and render each one of them in a RSLabel,
	 using a different metric class. We aim to draw its encompassing rectangle."

	RSMetricsProvider allSubclasses do: [ :metricClass | 
		| c words mp can |
		c := RSCanvas new.
		words := self unicodeSymbols.
		mp := metricClass new.
		words do: [ :word | 
			| label |
			label := RSLabel new
				         metricsProvider: mp;
				         text: word;
				         fontName: 'Menlo';
				         yourself.
			c add: label ].
		RSFlowLayout on: c nodes.
		c showEncompassingRectangles.
		can := RSCanvasController new.
		can configuration maxScale: 40.
		c @ can.
		{metricClass . c} inspect ]
]

{ #category : #tests }
RSLabelTest >> testCairoFitMetricsProviderOnUnicodeWords [

	"This test case collects unicode symbols and render each one of them in a RSLabel,
	 using a different metric class. We aim to draw its encompassing rectangle."

	self
		assert:
		(self unicodeStrings: 20 length: 10 random: (Random seed: 11))
		equals:
			#( '|ДǮÅ└ώюХЩƷ' 'ŔⅷĔζ―⒊θåœ∆' '‘דЮšǪ⋅©Ŀץⅷ' '«ι┸ѓï‴♢˘▐¯' 'ⅺ⌕☞ǐĩ⌂☜∂〜⌈'
			   'ІŲ‸³☻⒎Ξ┤¡℉' '☺ґ⅖ш┎Ј▽〗Ё〈' 'цŚÇÊ⒊ùΝאγЩ' '÷εįעא▷ñ〆〔≈' 'לέ┕₆тǩќų♪ן'
			   '▤ęģ♩ⅡǑ⒉Ψ┬в' 'чŞò⋯┣Ÿ∨Δ┕Љ' '|°»וǠ⌕ǵ₁【к' '∨Į₍мũźо⁰Оǥ' 'йшā⁹⑁нטŐ≈α'
			   'öסλłъ▲ρħ│⒏' '⇐ŦǍŢǮ▪Ⅱיϴы' 'Б−«≫≥¯≫е‸¦' '┇。█ŬĪάЬ〗∞Ч' 'ķל‥〓ǰåУ♣⒎Û' ).

	RSMetricsProvider allSubclasses do: [ :metricClass | 
		| c words mp can |
		c := RSCanvas new.
		words := self
			         unicodeStrings: 20
			         length: 10
			         random: (Random seed: 11).
		mp := metricClass new.
		words do: [ :word | 
			| label |
			label := RSLabel new
				         metricsProvider: mp;
				         text: word;
				         fontName: 'Menlo';
				         yourself.
			c add: label ].
		RSFlowLayout on: c nodes.
		c showEncompassingRectangles.
		can := RSCanvasController new.
		can configuration maxScale: 40.
		c @ can.
		{ 
			metricClass.
			c } inspect ]
]

{ #category : #tests }
RSLabelTest >> testDrawBorderLabel [
	|  |
	canvas addShape: (RSLabel new
		withBorder;
		color: (Color purple alpha: 0.5);
		fontName: 'Source Sans Pro';
		position: -50 @ 0;
		text: 'Hello world!';
		yourself).
	canvas createMorph drawOnMockCanvas.
]

{ #category : #tests }
RSLabelTest >> testDrawLabel [
	
	canvas addShape: (RSLabel new
		color: (Color purple alpha: 0.5);
		position: -50 @ 0;
		text: 'Hello world!';
		yourself).
	canvas createMorph drawOnMockCanvas.
]

{ #category : #tests }
RSLabelTest >> testHasChildren [
	| b |
	b := RSLabel new.
	self deny: b hasChildren.
	
]

{ #category : #tests }
RSLabelTest >> testModelWithoutText [

	| l |
	l := RSLabel new.
	self assert: l text isNil.
	self assert: l model isNil.
	
	l model: 42.
	self assert: l model equals: 42.
	self assert: l text equals: '42'
]

{ #category : #tests }
RSLabelTest >> testSameSize [
	| l1 l2 |
	l1 := RSLabel model: 123.
	l2 := RSLabel new text: 123.
	
	self assert: l1 extent equals: l2 extent
]

{ #category : #tests }
RSLabelTest >> testUnderlineStruckout [
	| label |
	label := RSLabel new.
	self assert: label isNormal.
	label underline.
	label bold.
	self assert: label isBold.
	self assert: label isUnderlined.
]

{ #category : #utility }
RSLabelTest >> unicodeStrings: n length: l random: r [

	| chars |
	chars := self unicodeSymbols.

	^ (1 to: n) collect: [ :i | 
		  '' join: ((1 to: l) collect: [ :_ | 
				   | j |
				   j := r nextInt: chars size.
				   chars at: j ]) ]
]

{ #category : #utility }
RSLabelTest >> unicodeSymbols [

	^ '| ¡ ¢ £ ¤ ¥ ¦ § ¨ © ª « ¬ ­ ® ¯ ° ± ² ³ ´ µ ¶ · ¸ ¹ º » ¼ ½ ¾ ¿ À Á Â Ã Ä Å Æ Ç È É Ê Ë Ì Í Î Ï Ð Ñ Ò Ó Ô Õ Ö × Ø Ù Ú Û Ü Ý Þ ß à á â ã ä å æ ç è é ê ë ì í î ï ð ñ ò ó ô õ ö ÷ ø ù ú û ü ý þ ÿ Ā ā Ă ă Ą ą Ć ć Ĉ ĉ Ċ ċ Č č Ď ď Đ đ Ē ē Ĕ ĕ Ė ė Ę ę Ě ě Ĝ ĝ Ğ ğ Ġ ġ Ģ ģ Ĥ ĥ Ħ ħ Ĩ ĩ Ī ī Ĭ ĭ Į į İ ı Ĳ ĳ Ĵ ĵ Ķ ķ ĸ Ĺ ĺ Ļ ļ Ľ ľ Ŀ ŀ Ł ł Ń ń Ņ ņ Ň ň ŉ Ŋ ŋ Ō ō Ŏ ŏ Ő ő Œ œ Ŕ ŕ Ŗ ŗ Ř ř Ś ś Ŝ ŝ Ş ş Š š Ţ ţ Ť ť Ŧ ŧ Ũ ũ Ū ū Ŭ ŭ Ů ů Ű ű Ų ų Ŵ ŵ Ŷ ŷ Ÿ Ź ź Ż ż Ž ž Ơ ơ Ƣ ƣ Ʀ Ư ư Ƶ ƶ Ʒ Ǎ ǎ Ǐ ǐ Ǒ ǒ Ǔ ǔ Ǟ ǟ Ǡ ǡ Ǣ ǣ Ǥ ǥ Ǧ ǧ Ǩ ǩ Ǫ ǫ Ǭ ǭ Ǯ ǯ ǰ Ǵ ǵ ʿ ˇ ˘ ˙ ˚ ˛ ˝ Ά Έ Ή Ί Ό Ύ Ώ ΐ Α Β Γ Δ Ε Ζ Η Θ Ι Κ Λ Μ Ν Ξ Ο Π Ρ Σ Τ Υ Φ Χ Ψ Ω Ϊ Ϋ ά έ ή ί ΰ α β γ δ ε ζ η θ ι κ λ μ ν ξ ο π ρ ς σ τ υ φ χ ψ ω ϊ ϋ ό ύ ώ Ϙ ϙ Ϛ ϛ Ϝ ϝ Ϟ ϟ Ϡ ϡ ϴ ϵ Ё Ђ Ѓ Є Ѕ І Ї Ј Љ Њ Ћ Ќ Ў Џ А Б В Г Д Е Ж З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Щ Ъ Ы Ь Э Ю Я а б в г д е ж з и й к л м н о п р с т у ф х ц ч ш щ ъ ы ь э ю я ё ђ ѓ є ѕ і ї ј љ њ ћ ќ ў џ Ѣ ѣ Ѫ ѫ Ѳ ѳ Ѵ ѵ Ҁ ҁ Ґ ґ א ב ג ד ה ו ז ח ט י ך כ ל ם מ ן נ ס ע ף פ ץ צ ק ר ש ת ، ‐ – — ― ‖ ‗ ‘ ’ ‚ ‛ “ ” „ ‟ † ‡ ‥ … ‰ ′ ″ ‴ ‵ ‶ ‷ ‸ ‹ › ※ ‾ ⁄ ⁰ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹ ⁺ ⁻ ⁼ ⁽ ⁾ ⁿ ₀ ₁ ₂ ₃ ₄ ₅ ₆ ₇ ₈ ₉ ₊ ₋ ₌ ₍ ₎ ₤ ₧ ₩ € ₽ ₽ ℃ ℅ ℉ № ℗ ℞ ℠ ™ Ω Å ⅓ ⅔ ⅕ ⅖ ⅗ ⅘ ⅙ ⅚ ⅛ ⅜ ⅝ ⅞ Ⅰ Ⅱ Ⅲ Ⅳ Ⅴ Ⅵ Ⅶ Ⅷ Ⅸ Ⅹ Ⅺ Ⅻ ⅰ ⅱ ⅲ ⅳ ⅴ ⅵ ⅶ ⅷ ⅸ ⅹ ⅺ ⅻ ← ↑ → ↓ ↔ ↕ ⇐ ⇒ ⇔ ∀ ∂ ∃ ∅ ∆ ∇ ∈ ∋ ∏ ∑ − ∓ ∗ ∘ ∙ √ ∝ ∞ ∟ ∠ ∥ ∧ ∨ ∩ ∪ ∫ ∬ ∮ ∴ ∵ ∶ ∷ ∼ ∾ ≃ ≅ ≈ ≌ ≓ ≠ ≡ ≤ ≥ ≪ ≫ ≮ ≯ ⊂ ⊃ ⊆ ⊇ ⊙ ⊚ ⊥ ⋅ ⋮ ⋯ ⌂ ⌈ ⌉ ⌊ ⌋ ⌐ ⌒ ⌕ ⌠ ⌡ 〈 〉 ␣ ⑀ ⑁ ⑂ ⑃ ⑆ ⑇ ⑈ ⑉ ⒈ ⒉ ⒊ ⒋ ⒌ ⒍ ⒎ ⒏ ⒐ ─ ━ │ ┃ ┄ ┅ ┆ ┇ ┈ ┉ ┊ ┋ ┌ ┍ ┎ ┏ ┐ ┑ ┒ ┓ └ ┕ ┖ ┗ ┘ ┙ ┚ ┛ ├ ┝ ┠ ┣ ┤ ┥ ┨ ┫ ┬ ┯ ┰ ┳ ┴ ┷ ┸ ┻ ┼ ┿ ╂ ╋ ╱ ╲ ▀ ▄ █ ▌ ▐ ░ ▒ ▓ ■ □ ▢ ▣ ▤ ▥ ▦ ▧ ▨ ▩ ▪ ▬ ▭ ▲ △ ▶ ▷ ▼ ▽ ◀ ◁ ◆ ◇ ◊ ○ ◎ ● ◐ ◑ ◘ ◙ ◢ ◣ ★ ☆ ☜ ☞ ☺ ☻ ☼ ♀ ♂ ♠ ♡ ♢ ♣ ♩ ♪ ♫ ♭ ♮ ♯ ✓ ✗ ✠ 　 、 。 〃 〄 々 〆 〇 《 》 「 」 『 』 【 】 〒 〓 〔 〕 〖 〗 〜' 
		  splitOn: ' '
]
