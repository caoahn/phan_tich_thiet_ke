/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

public class BorrowSlipDetail {
    private int id;
    private int borrowSlipId;
    private int documentCopyId;
    private int librarianId;

    public BorrowSlipDetail() {
    }

    public BorrowSlipDetail(int id,  int borrowSlipId, int documentCopyId, int librarianId) {
        this.id = id;
        this.borrowSlipId = borrowSlipId;
        this.documentCopyId = documentCopyId;
        this.librarianId = librarianId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBorrowSlipId() {
        return borrowSlipId;
    }

    public void setBorrowSlipId(int borrowSlipId) {
        this.borrowSlipId = borrowSlipId;
    }

    public int getDocumentCopyId() {
        return documentCopyId;
    }

    public void setDocumentCopyId(int documentCopyId) {
        this.documentCopyId = documentCopyId;
    }

    public int getLibrarianId() {
        return librarianId;
    }

    public void setLibrarianId(int librarianId) {
        this.librarianId = librarianId;
    }
}
