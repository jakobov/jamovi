
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"p0","title":"p₀ =","type":"String","default":"0.5"},{"name":"n","title":"n =","type":"Number","default":20},{"name":"k","title":"k =","type":"Number","default":5},{"name":"side","title":"","type":"List","options":[{"name":"leftSide","title":"Left Side"},{"name":"bothSides","title":"both Sides"},{"name":"rightSide","title":"Right Side"}],"default":"leftSide","description":{"R":"`'leftSide'` (default) , `'bothSides'` , `'rightSide'`. Decide on which Side you want to take the test\n"}},{"name":"alpha","title":"α =","type":"String","default":"0.05"},{"name":"showHypoPlot","title":"Show Hypothesis Plot","type":"Bool","default":true},{"name":"kLine","title":"Show k","type":"Bool","default":true},{"name":"scaleX","title":"Limit Scale to [μ-4*σ,μ+4*σ]","type":"Bool","default":true},{"name":"expl","title":"Show Explanation","type":"Bool","default":true},{"name":"showErrorPlot","title":"Show Error Plot","type":"Bool","default":false},{"name":"p","title":"p =","type":"String","default":"0.7"}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Hypothesis Test",
    jus: "3.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			cell: {"column":0,"row":0},
			style: "inline",
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Side of Test",
					iconPosition: "right",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "side_leftSide",
							fitToGrid: true,
							cell: {"column":0,"row":0},
							optionName: "side",
							optionPart: "leftSide"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "side_bothSides",
							fitToGrid: true,
							cell: {"column":1,"row":0},
							optionName: "side",
							optionPart: "bothSides"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "side_rightSide",
							fitToGrid: true,
							cell: {"column":2,"row":0},
							optionName: "side",
							optionPart: "rightSide"
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			cell: {"column":0,"row":1},
			style: "inline",
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Test Value",
					iconPosition: "right",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "p0",
							format: FormatDef.string
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			cell: {"column":1,"row":1},
			style: "inline",
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Observed Values",
					iconPosition: "right",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "n",
							format: FormatDef.number
						},
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "k",
							format: FormatDef.number
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			cell: {"column":2,"row":1},
			style: "inline",
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Significance Level",
					iconPosition: "right",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "alpha",
							format: FormatDef.string
						}
					]
				}
			]
		},
		{
			type: DefaultControls.CollapseBox,
			typeName: 'CollapseBox',
			label: "Plot Options",
			collapsed: true,
			controls: [
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "expl"
				},
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "showHypoPlot"
				},
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "kLine",
					enable: "(showHypoPlot)"
				},
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "scaleX",
					enable: "(showHypoPlot)"
				},
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "showErrorPlot"
				},
				{
					type: DefaultControls.TextBox,
					typeName: 'TextBox',
					name: "p",
					format: FormatDef.string,
					enable: "(showErrorPlot)"
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
