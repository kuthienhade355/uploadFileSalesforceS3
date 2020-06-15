public class Model_CV_TranMinhQuan {
    public String name {get;set;} 
	public String address {get;set;}
	public String phone {get;set;}
	public String email {get;set;}
	public String website {get;set;}
	public List<String> objective {get;set;}
	public List<Experience> experiences {get;set;} 
	public List<Education> educations {get;set;} 
	public List<String> skills {get;set;} 
	public List<ProjectUndertaken> projectUndertakens {get;set;}
	public List<String> hobbies{get;set;} 
	
    public class Experience {
		public Integer fromYear{get;set;}
		public Integer toYear{get;set;}
        public String description{get;set;}
        public Experience(Integer fromYear,Integer toYear,String description){
            this.fromYear = fromYear;
            this.toYear = toYear;
            this.description = description;
        }
	}
	public class Education{
		public Integer fromYear{get;set;}
		public Integer toYear{get;set;}
		public String title{get;set;}
		public String place{get;set;}
		public String department{get;set;}
		public String description{get;set;}
		public String content{get;set;}
		public Education(Integer fromYear,Integer toYear,String title,String place,String department,String description,String content){
			this.fromYear = fromYear;
			this.toYear = toYear;
			this.title = title;
			this.place = place;
			this.department = department;
			this.description = description;
			this.content = content;
		}
    }

	public class ProjectUndertaken{
		public String title{get;set;}
		public String description{get;set;}
		public String linkProject1{get;set;}
		public String linkProject2{get;set;}
		public ProjectUndertaken(String title,String description,String linkProject1,String linkProject2){
			this.title = title;
			this.description = description;
			this.linkProject1= linkProject1;
			this.linkProject2= linkProject2;

		}
		public ProjectUndertaken(){
			title = 'Technology and Software';
			description = 'React, dynamodb, AWS, Graphql, nodejs, filezilla';
	       	linkProject1 ='https://www.youtube.com/watch?v=UMIZ_Rx-v4Y&feature=youtu.be';
	       	linkProject2 = 'https://www.youtube.com/watch?v=GaQzddlGg&feature=youtu.be';
		}
	}
    
	public Model_CV_TranMinhQuan() {
		name = 'Tran Minh Quan';
        address = '355, Binh Quoi Street, 28 Ward, Binh Thanh District, Ho Chi Minh city, Viet Nam.';
        phone = '(84-0)1283859600';
        email = 'quandevkaizen@gmail.com';
       	website = 'Your Website';
       	objective = new List<String>();
       	objective.add('It for me to expand product to yourself, enjoy creative passion.');
       	objective.add('I want to have wide knowledge that I like and can communication with people.');
       	objective.add('I want to prove myself');
       	experiences = new List<Experience>();
       	experiences.add(new Experience(2015,2018,'Regular militia at ward'));
       	experiences.add(new Experience(null,2018,'Web Developer for Kaizen IT Solution Company'));
       	educations = new List<Education>();
       	educations.add(new Education(2013,2018,'Student','Ton Duc Thang University','Faculty of Electrical & Electronics Engineering',null,null));
       	educations.add(new Education(2016,2018,'Student','Aprotrain - Aptech Computer Education (Ho Chi Minh Center)','Obtain: DISM (Diploma information System Management)','HDSE (Higher Diploma Software Engineering).',null));
       	skills = new List<String>();
       	skills.add('C/C++, CSS3, HTML5, Javascript, Angular, React, Nodejs, AWS, mongo, dynamodb, Salesforce.');
       	projectUndertakens = new List<ProjectUndertaken>();
       	projectUndertakens.add(new ProjectUndertaken());
       	hobbies = new List<String>();
       	hobbies.add('I like listening to music, programing, read story, play game, soccer, and cinema.');
	}

	public String getJSONObjective() {
		return JSON.serialize(objective);
	}

	public String getJSONExperiences() {
		return JSON.serialize(experiences);
	}
    
    public String getJSONEducations(){
    	return JSON.serialize(educations);
    }

    public String getJSONSkills(){
    	return JSON.serialize(skills);
    }

    public String getJSONProjectUndertaken(){
    	return JSON.serialize(projectUndertakens);
    }

    public String getJSONHobbies(){
    	return JSON.serialize(hobbies);
    }

}