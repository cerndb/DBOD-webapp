
package ch.cern.dod.ws.egroups;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="egroupName" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="overwriteMembers" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="emails" type="{http://www.w3.org/2001/XMLSchema}string" maxOccurs="unbounded"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "egroupName",
    "overwriteMembers",
    "emails"
})
@XmlRootElement(name = "AddEgroupEmailMembersRequest")
public class AddEgroupEmailMembersRequest {

    @XmlElement(required = true)
    protected String egroupName;
    protected boolean overwriteMembers;
    @XmlElement(required = true)
    protected List<String> emails;

    /**
     * Gets the value of the egroupName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEgroupName() {
        return egroupName;
    }

    /**
     * Sets the value of the egroupName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEgroupName(String value) {
        this.egroupName = value;
    }

    /**
     * Gets the value of the overwriteMembers property.
     * 
     */
    public boolean isOverwriteMembers() {
        return overwriteMembers;
    }

    /**
     * Sets the value of the overwriteMembers property.
     * 
     */
    public void setOverwriteMembers(boolean value) {
        this.overwriteMembers = value;
    }

    /**
     * Gets the value of the emails property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the emails property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEmails().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getEmails() {
        if (emails == null) {
            emails = new ArrayList<String>();
        }
        return this.emails;
    }

}
