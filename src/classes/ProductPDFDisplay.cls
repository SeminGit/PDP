public virtual class ProductPDFDisplay{
	private List<Product2> productsList;
	public List<Product2> getproductsList(){
		return productsList;
	}
	public PageReference nextPage(){
		PageReference np = new PageReference('/apex/PDFPageToDownload');
		np.setRedirect(false);
		return np;
	}
	public PageReference downloadPDF(){
		System.PageReference pageRef = new System.PageReference('/apex/PDFPageToDownload');
		//ensure pdf downloads and is assigned with defined name
		pageRef.getHeaders().put('content-disposition', 'attachment; filename=TestPDF.pdf');
		return pageRef;
	}
}