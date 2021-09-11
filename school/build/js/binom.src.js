
// This file is an automatically generated and should not be edited

'use strict';

const options = [{"name":"data","type":"Data"},{"name":"p","title":"p =","type":"Number","default":0.5},{"name":"n1","title":"n =","type":"Number","default":10},{"name":"n2","title":"&","type":"Number","default":20},{"name":"n3","title":"&","type":"Number","default":30},{"name":"n","title":"n =","type":"Number","default":20},{"name":"p1","title":"p =","type":"Number","default":0.5},{"name":"p2","title":"&","type":"Number","default":0.7},{"name":"p3","title":"&","type":"Number","default":0.9},{"name":"mean","title":"Show mean (n*p)","type":"Bool","default":false},{"name":"std","title":"Show Standard Deviation (sqrt[n*p*(1-p)])","type":"Bool","default":false}];

const view = function() {
    
    this.handlers = { }

    View.extend({
        jus: "3.0",

        events: [

	]

    }).call(this);
}

view.layout = ui.extend({

    label: "Binomial Distribution",
    jus: "3.0",
    type: "root",
    stage: 0, //0 - release, 1 - development, 2 - proposed
    controls: [
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			fitToGrid: true,
			cell: {"column":0,"row":0},
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Different Size",
					iconPosition: "right",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "p",
							format: FormatDef.number,
							cell: {"column":0,"row":0}
						},
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "n1",
							format: FormatDef.number,
							cell: {"column":0,"row":1}
						},
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "n2",
							format: FormatDef.number,
							cell: {"column":1,"row":1}
						},
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "n3",
							format: FormatDef.number,
							cell: {"column":2,"row":1}
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			fitToGrid: true,
			cell: {"column":1,"row":0},
			controls: [
				{
					type: DefaultControls.Label,
					typeName: 'Label',
					label: "Different Probability",
					iconPosition: "right",
					controls: [
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "n",
							format: FormatDef.number,
							cell: {"column":0,"row":0}
						},
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "p1",
							format: FormatDef.number,
							cell: {"column":0,"row":1}
						},
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "p2",
							format: FormatDef.number,
							cell: {"column":1,"row":1}
						},
						{
							type: DefaultControls.TextBox,
							typeName: 'TextBox',
							name: "p3",
							format: FormatDef.number,
							cell: {"column":2,"row":1}
						}
					]
				}
			]
		},
		{
			type: DefaultControls.LayoutBox,
			typeName: 'LayoutBox',
			margin: "large",
			fitToGrid: true,
			cell: {"column":0,"row":1},
			controls: [
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "mean"
				},
				{
					type: DefaultControls.CheckBox,
					typeName: 'CheckBox',
					name: "std"
				}
			]
		}
	]
});

module.exports = { view : view, options: options };
