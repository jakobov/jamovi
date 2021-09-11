
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"throw","title":"Throw","type":"List","options":[{"title":"Coin 1","name":"c1"},{"title":"Coin 2","name":"c2"},{"title":"Dice 1","name":"d1"},{"title":"Dice 2","name":"d2"}],"default":"c1"},{"name":"num","title":"No. of trials (1-10000)","type":"Integer","default":10},{"name":"theoMean","title":"Show theoretical Mean","type":"Bool","default":false}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Law of Large Numbers",
    jus: "3.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			fitToGrid: true,
			cell: {"column":0,"row":1},
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Can you find out which coin and which dice is unfair?",
					format: FormatDef.label,
					cell: {"column":0,"row":0}
				},
				{
					type: DefaultControls.ComboBox,
					typeName: 'ComboBox',
					name: "throw",
					cell: {"column":0,"row":1}
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "num",
					format: FormatDef.number
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			controls: [
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "theoMean"
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
