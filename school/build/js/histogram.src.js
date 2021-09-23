
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"var","title":"Variable","type":"Variable"},{"name":"count","title":"Count","type":"List","options":[{"name":"abs","title":"Absolute Numbers"},{"name":"prop","title":"Proportions"}],"default":"abs","description":{"R":"`'abs'` (default) , `'prop'`. Choose wether to use absolute count or proportions on the y-axis\n"}},{"name":"bounds","title":"Set lower and upper bound","type":"List","options":[{"name":"format","title":"[l,u] = [Minimum,Maximum]"},{"name":"man","title":"[l,u] = "}],"default":"format","description":{"R":"`'format'` (default) , `'man'`. Choose wether to use set bounds for x-axis manually or format by rule\n"}},{"name":"lowerBound","title":"[","type":"Number","default":0},{"name":"upperBound","title":",","type":"Number","default":20},{"name":"bins","title":"Bins","type":"List","options":[{"name":"numBins","title":"Number of Bins"},{"name":"widthBins","title":"Binwidth"},{"name":"ruleBins","title":"Rule of Thumb"},{"name":"breakBins","title":"Set Breakpoints manually (Seperate by \",\")"}],"default":"numBins","description":{"R":"`'numBins'` (default) , `'breakBins'` , `'ruleBins'` or `'widthBins'`. Define Number of Bins, set Breakpoints manually, use rule of thumb or use binWidth , respectively\n"}},{"name":"numBinsN","title":"","type":"Integer","default":19},{"name":"widthBinsN","title":"","type":"Number","default":1},{"name":"ruleBinsN","title":"","type":"List","options":[{"name":"sqrtN","title":"SquareRoot(n)"},{"name":"logN","title":"10*Log10(n)"}],"default":"sqrtN"},{"name":"breakBinsN","title":"","type":"String","default":"0,1,10,20,100"}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Histogram",
    jus: "3.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.VariableSupplier,
			typeName: 'VariableSupplier',
			persistentItems: false,
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.TargetLayoutBox,
					typeName: 'TargetLayoutBox',
					label: "Variable to plot",
					controls: [
						{
							type: DefaultControls.VariablesListBox,
							typeName: 'VariablesListBox',
							name: "var",
							maxItemCount: 1,
							isTarget: true
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			style: "inline",
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Vertical Scale",
					iconPosition: "right",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "count_abs",
							optionName: "count",
							optionPart: "abs"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "count_prop",
							optionName: "count",
							optionPart: "prop"
						}
					]
				},
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Set lower and upper bound",
					iconPosition: "right",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "bounds_format",
							optionName: "bounds",
							optionPart: "format",
							enable: "(bins_numBins|| bins_widthBins || bins_ruleBins)"
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "bounds_man",
							optionName: "bounds",
							optionPart: "man",
							enable: "(bins_numBins|| bins_widthBins || bins_ruleBins)",
							style: "inline",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "lowerBound",
									format: FormatDef.number,
									enable: "(bounds_man && (bins_numBins|| bins_widthBins || bins_ruleBins))"
								},
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "upperBound",
									format: FormatDef.number,
									enable: "(bounds_man && (bins_numBins|| bins_widthBins || bins_ruleBins))",
									suffix: "]"
								}
							]
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			style: "inline",
			stretchFactor: 1,
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Adjust Bins",
					iconPosition: "right",
					controls: [
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "bins_numBins",
							fitToGrid: true,
							cell: {"column":0,"row":0},
							optionName: "bins",
							optionPart: "numBins",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "numBinsN",
									format: FormatDef.number,
									enable: "(bins_numBins)"
								}
							]
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "bins_widthBins",
							fitToGrid: true,
							cell: {"column":1,"row":0},
							optionName: "bins",
							optionPart: "widthBins",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "widthBinsN",
									format: FormatDef.number,
									enable: "(bins_widthBins)"
								}
							]
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "bins_breakBins",
							fitToGrid: true,
							cell: {"column":2,"row":0},
							optionName: "bins",
							optionPart: "breakBins",
							controls: [
								{
									type: DefaultControls.TextBox,
									typeName: 'TextBox',
									name: "breakBinsN",
									format: FormatDef.string,
									width: "largest",
									enable: "(bins_breakBins)"
								}
							]
						},
						{
							type: DefaultControls.RadioButton,
							typeName: 'RadioButton',
							name: "bins_ruleBins",
							fitToGrid: true,
							cell: {"column":0,"row":1},
							optionName: "bins",
							optionPart: "ruleBins",
							controls: [
								{
									type: DefaultControls.ComboBox,
									typeName: 'ComboBox',
									name: "ruleBinsN",
									enable: "(bins_ruleBins)"
								}
							]
						}
					]
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
