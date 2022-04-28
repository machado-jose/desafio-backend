$(function(){
  $("#deputy_expense_table").DataTable({
    "info": false,
    "dom": 'ftp',
    "deferRender": false,
    "language": {
      "url": "//cdn.datatables.net/plug-ins/1.11.5/i18n/pt-BR.json"
    },
    order: [[2, 'desc'], [0, 'desc'], [1, 'asc']],
    "pageLength": 20,
    responsive: true,
    columnDefs: [
      { className: 'text-center', targets: [0, 1, 2, 3]}
    ],
    "initComplete": function(settings, json){}
  })
})
