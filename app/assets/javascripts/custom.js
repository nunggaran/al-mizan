$(document).ready(function(){
	$('[data-provider="summernote"]').each(function(){
	  $(this).summernote({ 
	  	height: 600,   //set editable area's height
  		codemirror: { // codemirror options
    		theme: 'monokai'
  		},
  		placeholder: 'Masukkan article yang ingin ditulis',
		  hint: {
		    words: ['Al-Mizan', 'Anang Azharie Alie', 'Pondok Pesantren Modern Al-Mizan', 'Rangkasbitung', 'rangkasbitung', 'al-mizan', 'yana'],
		    match: /\b(\w{1,})$/,
		    search: function (keyword, callback) {
		      callback($.grep(this.words, function (item) {
		        return item.indexOf(keyword) === 0;
		      }));
		    }
		  }
	  });
	})
})