$(function(){
  $("#rank_deputy_table").DataTable({
    "info": false,
    "dom": 'ftp',
    "deferRender": false,
    "language": {
      "url": "//cdn.datatables.net/plug-ins/1.11.5/i18n/pt-BR.json"
    },
    order: [[1, 'desc'], [0, 'asc'], [2, 'desc']],
    "pageLength": 10,
    responsive: true,
    columnDefs: [
      { className: 'text-center', targets: [0, 1, 2, 3]}
    ],
    "initComplete": function(settings, json){}
  })
})
