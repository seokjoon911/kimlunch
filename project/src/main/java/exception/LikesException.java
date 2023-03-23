package exception;

public class LikesException extends RuntimeException {
	private String url;
	public LikesException(String msg, String url) {
		super(msg);
		this.url = url;
	}
	public String getUrl() {
		return url;
	}
}