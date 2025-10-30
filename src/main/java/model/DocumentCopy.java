package model;

public class DocumentCopy {
    private int id;
    private String documentCode;
    private String status;
    private int documentId;
    private String bookName;

    public DocumentCopy() {
    }

    public DocumentCopy(int id, String documentCode, String status, int documentId) {
        this.id = id;
        this.documentCode = documentCode;
        this.status = status;
        this.documentId = documentId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDocumentCode() {
        return documentCode;
    }

    public void setDocumentCode(String documentCode) {
        this.documentCode = documentCode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getDocumentId() {
        return documentId;
    }

    public void setDocumentId(int documentId) {
        this.documentId = documentId;
    }

    public String getBookName() {
        return bookName;
    }
    public void setBookName(String bookName) {
        this.bookName = bookName;
    }
}
