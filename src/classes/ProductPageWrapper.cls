// create a wrapper class with @AuraEnabled Properties
public class ProductPageWrapper{
	@AuraEnabled
	public Integer pageSize{
		get;
		set;
	}

	@AuraEnabled
	public Integer page{
		get;
		set;
	}

	@AuraEnabled
	public Integer total{
		get;
		set;
	}

	@AuraEnabled
	public List<Product2> products{
		get;
		set;
	}
}