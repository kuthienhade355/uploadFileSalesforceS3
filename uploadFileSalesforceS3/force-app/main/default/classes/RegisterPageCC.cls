public with sharing class RegisterPageCC {
	
	public Register__c register {get;set;}

	public RegisterPageCC(){
		Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
		if(cookie!=null){
			this.register = getRegister(cookie.getValue());	
		}
	}

	public PageReference init(){
	Cookie cookie = apexpages.currentPage().getCookies().get('urlID');
	PageReference p = new PageReference('/apex/loginHRManager');
	if(cookie!=null){
			return null;
		}
		p.setRedirect(true);
		return p;
	}

	public Register__c getRegister(String urlID){
		//list sobject
		Register__c c  = [SELECT Company__c,Id,First_Name__c,Title_Job__c,Last_Name__c,Email__c,Phone__c FROM Register__c Where id =: urlID Limit 1];
		return c;
	}

	public String getExperience1(){
		Cookie cookie = ApexPages.currentPage().getCookies().get('urlID');
		String urlID = cookie.getValue();
		List<Experience1__c> experience = [SELECT Description__c,Name__c FROM Experience1__c Where CustomUser__c =:urlID]; 
		String jsonstrng = String.escapeSingleQuotes(JSON.serialize(experience));
		return jsonstrng;
	}

	public String getStoreCandidate(){
		List<Store_Candidate__c> storeCandidates = [SELECT PositionStatus__c,Id,Phone__c,Approval_Status__c,Email__c,First_Name__c,Last_Name__c,City__c,Status__c,(SELECT Id, Name FROM Attachments) FROM Store_Candidate__c];
		return JSON.serialize(storeCandidates);
	}

	public String getFunctions(){
		List<Function__c> functions =[SELECT Active__c, Title__c, Name__c,ParentID__c FROM Function__c];
		return JSON.serialize(functions);
	}

	public PageReference getLogOut(){
		PageReference page = new PageReference('/apex/loginHRManager');
		Cookie cookie = new Cookie('urlId', '',null,0,false);
		ApexPages.currentPage().setCookies(new Cookie[]{cookie});
		page.setRedirect(true);
		return page;
	}


	@RemoteAction
    public static Candidate_Position__c saveEditPosition(Id id,Decimal duration,String company,Decimal salary,String location,String jobDescription){
            Store_Position__c sp = new Store_Position__c();
            sp.Company__c = company;
            sp.Duration__c = duration;
            sp.Job_Description__c = jobDescription;
            sp.Location__c = location;
            sp.Salary__c = salary;
    		insert sp;
    		Candidate_Position__c cp = new Candidate_Position__c();
    		cp.Store_Candidate__c = id;
    		cp.Store_Position__c = sp.Id;
    		insert cp;
            return null;
    } 

    @RemoteAction
    public static Store_Candidate__c saveEditCandidation(String LastName1,String FirstName1,String City1,String Email1,String Phone1,Boolean Status1,Blob file){
            Store_Candidate__c sc = new Store_Candidate__c();
            sc.First_Name__c = FirstName1;
            sc.Email__c = Email1;
            sc.City__c = City1;
            sc.Last_Name__c = LastName1;
            sc.Phone__c = Phone1;
            sc.Status__c = false;
    		insert sc;
            return null;
     } 

    @RemoteAction
    public static Candidate_Position__c showDetailDocument(String id){
     	Candidate_Position__c cp = [SELECT Store_Candidate__r.Last_Name__c,
     								Store_Candidate__r.First_Name__c,
									Store_Candidate__r.Email__c,
									Store_Candidate__r.City__c,
									Store_Candidate__r.Phone__c,
									Store_Candidate__r.Status__c,
									Store_Position__r.Duration__c,
									Store_Position__r.Company__c,
									Store_Position__r.Salary__c,
									Store_Position__r.Location__c,
									Store_Position__r.Job_Description__c FROM Candidate_Position__c WHERE Store_Candidate__c =:id];
		return cp;
	}
}