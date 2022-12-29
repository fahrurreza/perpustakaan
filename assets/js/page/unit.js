const App = {
  data() {
    return {
      show: false,
      submit : true,
      items : [],
      entriesOption : [{'value' : 10},{'value' : 25},{'value' : 50}, {'value' : 100}],
      table : {
        column : 'unit_name',
        keyword : '',
        perPage : 10,
        pageSelect : 1,
        name : 'Menu',
        id : null
      },
      meta : [],
      buttonPage : [],
      form:{
        id : null,
        unit_name : null,
        code_name : null,
        unit_details : null,
        status : null,
        short_order : null
      },
      hasError : {
        unit_name : false,
        code_name : false,
        unit_details : false,
        status : false,
        short_order : false
      },
      error: {
        unit_name : false,
        code_name : false,
        unit_details : false,
        status : false,
        short_order : false
      },
    }
  },
  methods:{
    getData: function(data){
      axios.post('api/get-unit', data)
         .then(response => {
            if(response.status == 200){
              this.items = response.data.data
              this.meta = response.data.meta
              let page = {};
              for (let i = 0; i < this.meta.last_page; i++) {
                page[i]= {'page' : i+1};
              }
              this.buttonPage = page
            }else{
              notifError('Error')
            }
         })
         .catch(error => {
            notifError('Error')
         })
    },

    resetForm: function () { 
        this.form.unit_name = null,
        this.form.code_name = null,
        this.form.unit_details = null,
        this.form.status = null,
        this.form.short_order = null
    },

    createData:function(e) {
      this.error = [];
      this.hasError = [];
      e.preventDefault();
      if(!this.form.unit_name) {
        this.error.unit_name = "type is required";
        this.hasError.unit_name = true;
        
      }
      else if(!this.form.code_name) {
        this.error.code_name = "Label is required";
        this.hasError.code_name = true;
      }
      else if(!this.form.short_order) {
        this.error.short_order= "Link is required";
        this.hasError.short_order = true;
      }
      else if(!this.form.status) {
        this.error.status= "Status is required";
        this.hasError.status = true;
      } else {
        axios
        .post('api/create-unit', this.form)
        .then(response => {
          if(response.status == 200){
            this.items = response.data.data
            this.meta = response.data.meta
            let page = {};
            for (let i = 0; i < this.meta.last_page; i++) {
              page[i]= {'page' : i+1};
            }
            this.buttonPage = page
            this.resetForm()
            notifSuccess('Data berhasil disimpan')
          }else{
            notifError('Data not found')
          }
        })
        .catch(error => {
          console.log(error)
          this.errored = true
          notifError('Somethingelse')
        })
      }
    },

    editData: function(data){
      this.show = true
      this.table.id = data
      this.submit = false
      axios.post('api/show-unit', this.table).then(response => {
        if(response.status == 200){
          
          this.form.id = response.data.unit_id
          this.form.unit_name = response.data.unit_name
          this.form.code_name = response.data.code_name
          this.form.unit_details = response.data.unit_details
          this.form.short_order = response.data.short_order
          this.form.status = response.data.status

        }else{
          notifError('Data not found')
        }
      })
      .catch(error => {
          notifError('Somethink else')
      })
    },

    updateData: function(data){
      axios.post('api/update-unit', this.form).then(response => {
        if(response.status == 200){
          this.items = response.data.data
          this.meta = response.data.meta
          let page = {};
          for (let i = 0; i < this.meta.last_page; i++) {
            page[i]= {'page' : i+1};
          }
          this.buttonPage = page
          this.resetForm()
          this.show = false
          notifSuccess('Data berhasil diupdate')
        }else{
          notifError('Data gagal diupdate')
        }
      })
      .catch(error => {
          notifError('Somethink else')
      })
    },

    entries: function(){
      this.table.pageSelect = 1
      this.getData(this.table)
    },

    search: function(column){
      this.table.pageSelect = null
      this.table.column = column
      var value = document.getElementById(column).value
      this.table.keyword = value

      this.getData(this.table)
    },

    page: function(data){
      this.table.pageSelect = data
      this.getData(this.table)
    },
    
    nextPage: function(){
      if(this.table.pageSelect < this.meta.last_page)
      {
        this.table.pageSelect++
        this.getData(this.table)
      }
    },

    backPage: function(){
      if(this.table.pageSelect > 1)
      {
        this.table.pageSelect--
        this.getData(this.table)
      }
    },

    deleteData: function(data){
      this.table.id = data
      Swal.fire({
        title: 'Apakah kamu yakin?',
        text: "Data ini akan di hapus dan tidak dapat dikembalikan!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
      }).then((result) => {
        if (result.isConfirmed) {
          axios.post('api/delete-unit', this.table).then(response => {
              if(response.status == 200){
                this.items = response.data.data
                let page = {};
                for (let i = 0; i < this.meta.last_page; i++) {
                  page[i]= {'page' : i+1};
                }
                this.buttonPage = page
                notifSuccess('Data berhasil dihapus')
              }else{
                notifError('Data gagal dihapus')
              }
          })
          .catch(error => {
              notifError('Somethink else')
          })
        }
      })
    },

    openForm: function(){
      this.show = true
    },
    closeForm: function(){
      this.show = false
    }
  },

  mounted() {
    this.getData(this.table)
  }
};
Vue.createApp(App).mount("#app");