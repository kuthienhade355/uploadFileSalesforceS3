public with sharing class CV_TranMinhQuan {
    public String name {get;set;} 
	public String address {get;set;}
	public String phone {get;set;}
	public String email {get;set;}
	public String website {get;set;}
	public String objective {get;set;}
	public List<Experience> experiences {get;set;} 
	public List<Education> educations {get;set;} 
	public List<String> skills {get;set;} 
	public List<ProjectUndertaken> projectUndertakens {get;set;}
	public List<String> hobbies{get;set;} 
        public class Experience {
		public Integer fromYear{get;set;}
		public Integer toYear{get;set;}
		public String description{get;set;}
	}

	public class Education{
		public Integer fromYear{get;set;}
		public Integer toYear{get;set;}
		public String title{get;set;}
		public String place{get;set;}
		public String department{get;set;}
		public String description{get;set;}
		public String content{get;set;}
    }

	public class ProjectUndertaken{
		public String title{get;set;}
		public String description{get;set;}
		public List<String> linkProject{get;set;}
	}
	CV_TranMinhQuan() {
		name = 'Tran Minh Quan';
        address = '355, Binh Quoi Street, 28 Ward, Binh Thanh District, Ho Chi Minh city, Viet Nam.';
        phone = '(84-0)1283859600';
	}
}