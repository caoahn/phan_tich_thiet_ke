/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

public class BorrowSlipDetail {
    private int id;
    private String description;
    private int borrowTaskDetailId;
    private int borrowSlipId;
    private int documentCopyId;
    private int librarianId;

    public BorrowSlipDetail() {
    }

    public BorrowSlipDetail(int id, String description, int borrowTaskDetailId, int borrowSlipId, int documentCopyId, int librarianId) {
        this.id = id;
        this.description = description;
        this.borrowTaskDetailId = borrowTaskDetailId;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getBorrowTaskDetailId() {
        return borrowTaskDetailId;
    }

    public void setBorrowTaskDetailId(int borrowTaskDetailId) {
        this.borrowTaskDetailId = borrowTaskDetailId;
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
