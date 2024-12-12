<!-- default badges list -->
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/E5000)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
[![](https://img.shields.io/badge/💬_Leave_Feedback-feecdd?style=flat-square)](#does-this-example-address-your-development-requirementsobjectives)
<!-- default badges end -->

# SelectBox for DevExtreme - How to implement standalone and in-form cascading SelectBoxes

This example demonstrates how to implement cascading SelectBoxes in the following scenarios:

- Standalone SelectBoxes
- SelectBoxes in Form

When you select a value from the first SelectBox, the second SelectBox loads the filtered values. In this example, only cities from the selected state appear in the second SelectBox.

<div align="center"><img alt="Implement standalone and in-Form cascading SelectBoxes" src="devextreme-cascading-selectboxes.png" /></div>

To implement this functionality, get the [value](https://js.devexpress.com/Documentation/ApiReference/UI_Components/dxSelectBox/Configuration/#value) from the first editor and [filter](https://js.devexpress.com/Documentation/ApiReference/Data_Layer/DataSource/Methods/#filter) the [dataSource](https://js.devexpress.com/Documentation/ApiReference/UI_Components/dxSelectBox/Configuration/#dataSource) by this **value** in the second editor.

## Files to Review

- **jQuery**
    - [index.html](jQuery/index.html)
- **Angular**
    - [app.component.html](Angular/src/app/app.component.html)
    - [app.component.ts](Angular/src/app/app.component.ts)
- **Vue**
    - [App.vue](Vue/src/App.vue)
- **React**
    - [App.js](React/src/App.js)
- **NetCore**    
    - [Index.cshtml](NetCore/CascadingSelectBoxesSample/Views/Home/Index.cshtml)

## Documentation

- [Getting Started with SelectBox](https://js.devexpress.com/Documentation/Guide/UI_Components/SelectBox/Getting_Started_with_SelectBox/)

- [SelectBox - API Reference](https://js.devexpress.com/Documentation/ApiReference/UI_Components/dxSelectBox/)

## More Examples

- [DataGrid for DevExtreme - How to implement cascading DropDownBoxes](https://github.com/DevExpress-Examples/devextreme-datagrid-implement-cascading-dropdownboxes)
<!-- feedback -->
## Does this example address your development requirements/objectives?

[<img src="https://www.devexpress.com/support/examples/i/yes-button.svg"/>](https://www.devexpress.com/support/examples/survey.xml?utm_source=github&utm_campaign=devextreme-cascading-selectboxes&~~~was_helpful=yes) [<img src="https://www.devexpress.com/support/examples/i/no-button.svg"/>](https://www.devexpress.com/support/examples/survey.xml?utm_source=github&utm_campaign=devextreme-cascading-selectboxes&~~~was_helpful=no)

(you will be redirected to DevExpress.com to submit your response)
<!-- feedback end -->
