public class PDFController {
	    public List<Product2> productsList {get;set;}
    	public string selectedLang{get;set;}
    	
    public PDFController(){
        selectedLang = 'en';
    }
    
    	public PageReference downloadPDF(){
        System.PageReference pageRef = new System.PageReference('/apex/PDFPageToDownload');
    
        //ensure pdf downloads and is assigned with defined name
        pageRef.getHeaders().put('content-disposition', 'attachment; filename=TestPDF.pdf');
     
        return pageRef;
    }
}