package com.NoviBackend.WalletWatch.user.dto;

public class RegularUserDto {
    private String username;
    private String firstName;
    private String surname;
    private String emailAddress;
    private int subscriptionsAmount;

    public RegularUserDto(){

    }

    public RegularUserDto(String username, String firstName, String surname, String emailAddress) {
        this.username = username;
        this.firstName = firstName;
        this.surname = surname;
        this.emailAddress = emailAddress;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }
}
